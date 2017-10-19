module InciScore
  class Normalizer
    module Rules
      SEPARATOR = ','

      module Replacer
        extend self

        REPLACEMENTS = [
          [/\n+|\t+/, ' '],
          ['‘', "'"],
          ['—', '-'],
          ['_', ' '],
          ['~', '-'],
          ['|', 'l'],
          [' I ', '/']
        ]

        def call(src)
          REPLACEMENTS.reduce(src) do |_src, replacement|
            invalid, valid = *replacement
            _src.index(invalid) ? _src.gsub(invalid, valid) : _src
          end
        end
      end

      module Downcaser
        extend self

        def call(src)
          src.downcase
        end
      end 

      module Beheader
        extend self

        TITLE_SEP = ':'
        MAX_INDEX = 50

        def call(src)
          sep_index = src.index(TITLE_SEP)
          return src if !sep_index || sep_index > MAX_INDEX
          src[sep_index+1, src.size]
        end
      end

      module Separator
        extend self

        SEPARATORS = ["; ", ". ", " ' ", " - ", " : "]

        def call(src)
          SEPARATORS.reduce(src) do |_src, separator|
            _src = _src.gsub(separator, SEPARATOR)
          end
        end
      end 

      module Tokenizer
        extend self

        def call(src)
          src.split(SEPARATOR).map(&:strip)
        end
      end

      module Sanitizer
        extend self

        INVALID_CHARS = /[^\/\[\]\(\)\w\s-]/

        def call(src)
          Array(src).map do |token|
            token.gsub(INVALID_CHARS, '')
          end.reject(&:empty?)
        end
      end

      module Uniquifier
        extend self

        def call(src)
          Array(src).uniq
        end
      end
    end
  end
end
