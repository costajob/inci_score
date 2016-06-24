require 'inci_score/levenshtein'

module InciScore
  class Recognizer
    module Rules
      class Base
        TOLERANCE = 3

        def initialize(src, catalog)
          @src = src
          @catalog = catalog
        end

        def call
          fail NotmplementedError
        end
      end

      class Key < Base
        def call
          @src if @catalog.has_key?(@src)
        end
      end

      class Levenshtein < Base
        ALTERNATE_SEP  = '/'

        def call
          size = @src.size
          component, distance = @catalog.reduce([nil, size]) do |min, (component, _)|
            match = (n = component.index(ALTERNATE_SEP)) ? component[0, n] : component
            next min if match.size > (size + TOLERANCE)
            dist = @src.distance(match)
            min = [component, dist] if dist < min[1]
            min
          end
          component unless distance > TOLERANCE || distance >= (size-1)
        end
      end

      class Digits < Base
        MIN_MEANINGFUL = 7

        def call
          return if @src.size < TOLERANCE
          digits = @src[0, MIN_MEANINGFUL]
          @catalog.detect do |component, _| 
            component.match(/^#{Regexp::escape(digits)}/)
          end.to_a.first
        end
      end

      class Tokens < Base
        UNMATCHABLE = %w[extract oil sodium acid sulfate]
      
        def call
          tokens.each do |token|
            @catalog.each do |component, _| 
              return component if component.match(/\b#{Regexp.escape(token)}\b/)
            end
          end
          nil
        end

        private 
        
        def tokens
          (@src.split(' ') - UNMATCHABLE).reject { |t| t.size < TOLERANCE }.sort_by!(&:size).reverse!
        end
      end
    end
  end
end
