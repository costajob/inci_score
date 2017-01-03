require 'inci_score/normalizer_rules'

module InciScore
  class Normalizer
    DEFAULT_RULES = [Rules::Replacer, Rules::Downcaser, Rules::Beheader, Rules::Separator, Rules::Tokenizer, Rules::Sanitizer, Rules::Desynonymizer]

    attr_reader :src

    def initialize(options = {})
      @src = options[:src] || fail(ArgumentError, 'missing src')
      @rules = options.fetch(:rules) { DEFAULT_RULES }
    end

    def call
      yield(@rules) if block_given?
      @rules.reduce(@src) do |src, rule|
        @src = rule.call(src)
      end
    end
  end
end
