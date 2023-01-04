# frozen_string_literal: true

module InciScore
  using Refinements

  class Recognizer
    module Rules
      TOLERANCE = 3

      Key = ->(src) { src if Config::CATALOG.has_key?(src) }

      Hazard = ->(src) { 'generic-hazard' if Config::HAZARDS.any? { |h| src.include?(h) } }

      module Levenshtein
        extend self

        Result = Struct.new(:name, :distance) do
          def tolerable?(size)
            distance < TOLERANCE && distance <= (size-1)
          end
        end

        def call(src)
          return if src.empty?
          size = src.size
          farthest = Result.new(nil, size)
          initial = src[0]
          result = Config::CATALOG.reduce(farthest) do |nearest, (component, _)|
            next nearest unless component.start_with?(initial)
            next nearest if component.size > (size + TOLERANCE)
            d = src.distance(component)
            nearest = Result.new(component, d) if d < nearest.distance
            nearest
          end
          result.name if result.tolerable?(size)
        end
      end

      module Prefix
        extend self

        MIN_MEANINGFUL = 7

        def call(src)
          return if src.size < TOLERANCE
          digits = src[0, MIN_MEANINGFUL]
          Config::CATALOG.detect { |component, _| component.start_with?(digits) }.to_a.first
        end
      end

      module Tokens
        extend self

        UNMATCHABLE = %w[extract oil sodium acid sulfate].freeze

        def call(src)
          return if src.size <= TOLERANCE
          tokens(src).each do |token|
            Config::CATALOG.each do |component, _|
              return component if component.include?(token)
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
