# frozen_string_literal: true

module InciScore
  class Normalizer
    module Rules
      SEPARATOR = ','

      Downcaser = ->(src) { src.downcase }.freeze

      Tokenizer = ->(src) { src.split(SEPARATOR).map(&:strip) }.freeze

      Uniquifier = ->(src) { Array(src).uniq }.freeze

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
        ].freeze

        def call(src)
          REPLACEMENTS.reduce(src) do |_src, replacement|
            invalid, valid = *replacement
            _src.index(invalid) ? _src.gsub(invalid, valid) : _src
          end
        end
      end

      module Beheader
        extend self

        TITLE_SEP = ':'
        MAX_INDEX = 50

        def call(src)
          sep_index = src.index(TITLE_SEP)
          return src unless sep_index
          return src if sep_index > MAX_INDEX
          src[sep_index+1, src.size]
        end
      end

      module Separator
        extend self

        SEPARATORS = ['; ', '. ', " ' ", ' - ', ' : '].freeze

        def call(src)
          SEPARATORS.reduce(src) do |_src, separator|
            _src = _src.gsub(separator, SEPARATOR)
          end
        end
      end

      module Sanitizer
        extend self

        INVALID_CHARS = /[^\/\[\]\(\)\w\s-]/.freeze

        def call(src)
          Array(src).map do |token|
            token.gsub(INVALID_CHARS, '')
          end.reject(&:empty?)
        end
      end
    end
  end
end
