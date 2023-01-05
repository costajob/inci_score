# frozen_string_literal: true

module InciScore
  using Refinements

  class Recognizer
    module Rules
      TOLERANCE = 3

      Component = Struct.new(:name, :hazard) do
        def to_s
          "#{name} (#{hazard})"
        end
      end

      Key = ->(src) do
        score = Config::CATALOG[src]
        Component.new(src, score) if score
      end

      Hazard = ->(src) do
        if hazard = Config::HAZARDS.detect { |name, _| src.include?(name) }
          Component.new(src, hazard.last)
        end
      end

      module Levenshtein
        extend self

        Result = Struct.new(:name, :distance, :score) do
          def tolerable?(size, tolerance)
            distance < tolerance && distance <= (size-1)
          end
        end

        def call(src)
          return if src.empty?
          size = src.size
          t = tolerance(size)
          farthest = Result.new(nil, size)
          initial = src[0]
          result = Config::CATALOG.reduce(farthest) do |nearest, (name, score)|
            next nearest unless name.start_with?(initial)
            next nearest if name.size > (size + t)
            d = src.distance(name)
            nearest = Result.new(name, d, score) if d < nearest.distance
            nearest
          end
          Component.new(result.name, result.score) if result.tolerable?(size, t)
        end

        private

        def tolerance(size)
          Math.log(size, 1.8).round
        end
      end

      module Prefix
        extend self

        MIN_MEANINGFUL = 7

        def call(src)
          return if src.size < TOLERANCE
          digits = src[0, MIN_MEANINGFUL]
          pairs = Config::CATALOG.detect { |name, _| name.start_with?(digits) }
          Component.new(*pairs) if pairs
        end
      end

      module Tokens
        extend self

        UNMATCHABLE = %w[extract oil sodium acid sulfate].freeze

        def call(src)
          return if src.size <= TOLERANCE
          tokens(src).each do |token|
            Config::CATALOG.each do |name, score|
              return Component.new(name, score) if name.include?(token)
            end
          end
          nil
        end

        private

        def tokens(src)
          words = src.split(' ').map { |w| w.split('-') }.flatten
          (words - UNMATCHABLE).reject { |t| t.size < TOLERANCE }.sort! { |a, b| b.size <=> a.size }
        end
      end
    end
  end
end
