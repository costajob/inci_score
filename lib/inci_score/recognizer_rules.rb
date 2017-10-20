require "inci_score/refinements"

module InciScore
  using Refinements
  class Recognizer
    module Rules
      TOLERANCE = 3

      module Key
        extend self

        def call(src, catalog)
          src if catalog.has_key?(src)
        end
      end

      module Levenshtein
        extend self

        Result = Struct.new(:name, :distance) do
          def tolerable?(size)
            distance < TOLERANCE && distance <= (size-1)
          end
        end

        def call(src, catalog)
          size = src.size
          farthest = Result.new(nil, size)
          initial = src[0]
          result = catalog.reduce(farthest) do |nearest, (component, _)|
            next nearest unless component.start_with?(initial)
            next nearest if component.size > (size + TOLERANCE)
            d = src.distance(component)
            nearest = Result.new(component, d) if d < nearest.distance
            nearest
          end
          result.name if result.tolerable?(size)
        end
      end

      module Digits
        extend self

        MIN_MEANINGFUL = 7

        def call(src, catalog)
          return if src.size < TOLERANCE
          digits = src[0, MIN_MEANINGFUL]
          catalog.detect { |component, _| component.start_with?(digits) }.to_a.first
        end
      end

      module Tokens
        extend self

        UNMATCHABLE = %w[extract oil sodium acid sulfate]
      
        def call(src, catalog)
          tokens(src).each do |token|
            catalog.each do |component, _| 
              return component if component.include?(token)
            end
          end
          nil
        end

        def tokens(src)
          (src.split(" ") - UNMATCHABLE).reject { |t| t.size < TOLERANCE }.sort! { |a, b| b.size <=> a.size }
        end
      end
    end
  end
end
