require 'inci_score/levenshtein'

module InciScore
  class Recognizer
    module Rules
      class Base
        TOLERANCE = 3

        def initialize(src, catalog)
          @src = src
          @catalog = catalog
          @components = catalog.keys
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
          initial = @src[0]
          size = @src.size
          component, distance = @components.reduce([nil, size]) do |min, component|
            next min unless component.start_with?(initial)
            match = (n = component.index(ALTERNATE_SEP)) ? component[0, n] : component
            dist = @src.distance(match)
            min = [component, dist] if dist < min[1]
            min
          end
          return if distance > TOLERANCE || distance >= (size-1)
          component
        end
      end

      class Digits < Base
        MIN_MEANINGFUL = 7

        def call
          return if @src.size < TOLERANCE
          digits = @src[0, MIN_MEANINGFUL]
          @components.detect do |component| 
            component.match(/^#{Regexp::escape(digits)}/)
          end
        end
      end

      class Tokens < Base
        UNMATCHABLE = %w[extract oil sodium acid sulfate]
      
        def call
          @components.detect do |component| 
            tokens.detect do |token|
              component.match(/\b#{Regexp::escape(token)}\b/)
            end
          end
        end

        private def tokens
          (@src.split(' ') - UNMATCHABLE).reject { |t| t.size < TOLERANCE }.sort_by!(&:size).reverse!
        end
      end
    end
  end
end
