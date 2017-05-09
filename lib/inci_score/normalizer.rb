require 'inci_score/normalizer_rules'

module InciScore
  class Normalizer
    DEFAULT_RULES = [Rules::Replacer, Rules::Downcaser, Rules::Beheader, Rules::Separator, Rules::Tokenizer, Rules::Sanitizer, Rules::Desynonymizer, Rules::Uniquifier]

    attr_reader :src

    def initialize(src:, rules: DEFAULT_RULES)
      @src = src
      @rules = rules
    end

    def call
      yield(@rules) if block_given?
      @rules.reduce(@src) do |src, rule|
        @src = rule.call(src)
      end
    end
  end
end
