require "inci_score/refinements"

module InciScore
  using Refinements
  class Recognizer
    module Rules
      TOLERANCE = 3

      module Key
        extend self

        def call(src, catalog, precise = false)
          src if catalog.has_key?(src)
        end
      end

      module Levenshtein
        extend self

        ALTERNATE_SEP  = "/"

        def call(src, catalog, precise = false)
          size = src.size
          initial = src[0]
          component, distance = catalog.reduce([nil, size]) do |min, (_component, _)|
            next min unless precise || _component.start_with?(initial)
            match = (n = _component.index(ALTERNATE_SEP)) ? _component[0, n] : _component
            next min if match.size > (size + TOLERANCE)
            dist = src.distance(match)
            min = [_component, dist] if dist < min[1]
            min
          end
          component unless distance > TOLERANCE || distance >= (size-1)
        end
      end

      module Digits
        extend self

        MIN_MEANINGFUL = 7

        def call(src, catalog, precise = false)
          return if src.size < TOLERANCE
          digits = src[0, min_meaningful(precise)]
          catalog.detect do |component, _| 
            component.matches?(/^#{Regexp::escape(digits)}/)
          end.to_a.first
        end

        def min_meaningful(precise)
          return MIN_MEANINGFUL unless precise
          MIN_MEANINGFUL + 2
        end
      end

      module Tokens
        extend self

        UNMATCHABLE = %w[extract oil sodium acid sulfate]
      
        def call(src, catalog, precise = false)
          tokens(src).each do |token|
            catalog.each do |component, _| 
              return component if component.matches?(/\b#{Regexp.escape(token)}\b/)
            end
          end
          nil
        end

        def tokens(src)
          (src.split(" ") - UNMATCHABLE).reject { |t| t.size < TOLERANCE }.sort_by!(&:size).reverse!
        end
      end
    end
  end
end
