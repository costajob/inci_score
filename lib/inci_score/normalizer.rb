# frozen_string_literal: true

module InciScore
  class Normalizer
    DEFAULT_RULES = [Rules::Replacer, Rules::Downcaser, Rules::Beheader, Rules::Separator, Rules::Tokenizer, Rules::Sanitizer, Rules::Uniquifier].freeze

    attr_reader :src, :rules

    def initialize(src:, rules: DEFAULT_RULES)
      @src = src
      @rules = rules
      freeze
    end

    def call
      rules.reduce(src) do |_src, rule|
        _src = rule.call(_src)
      end
    end
  end
end
