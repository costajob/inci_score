module InciScore
  class Normalizer
    module Rules
      class Base
        SEPARATOR = ','

        def initialize(src)
          @src = src
        end

        def call
          fail NotImplementedError
        end
      end

      class Replacer < Base
        REPLACEMENTS = [
          [/\n+|\t+/, ' '],
          ['‘', "'"],
          ['—', '-'],
          ['(', 'C'],
          ['_', ' '],
          ['~', '-'],
          ['|', 'l'],
          [' I ', '/']
        ]

        def call
          REPLACEMENTS.reduce(@src) do |src, replacement|
            invalid, valid = *replacement
            src.index(invalid) ? src.gsub(invalid, valid) : src
          end
        end
      end

      class Downcaser < Base
        def call 
          @src.downcase
        end
      end 

      class Beheader < Base
        TITLE_SEP = ':'
        MAX_INDEX = 50

        def call
          sep_index = @src.index(TITLE_SEP)
          return @src if !sep_index || sep_index > MAX_INDEX
          @src[sep_index+1, @src.size]
        end
      end

      class Separator < Base
        SEPARATORS = ["; ", ". ", " ' ", " - ", " : "]

        def call
          SEPARATORS.reduce(@src) do |src, separator|
            src = src.gsub(separator, SEPARATOR)
          end
        end
      end 

      class Tokenizer < Base
        INVALID_CHARS = /[^\w\s-]/

        def call
          @src.split(SEPARATOR).map do |token|
            token = token.sub(/\/.*/, '')
            token = token.gsub(INVALID_CHARS, '')
            token = token.strip
          end.reject(&:empty?)
        end
      end
    end
  end
end
