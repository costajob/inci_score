# frozen_string_literal: true

require 'inci_score/normalizer_rules'

module InciScore
  class Normalizer
    DEFAULT_RULES = [Rules::Replacer, Rules::Downcaser, Rules::Beheader, Rules::Separator, Rules::Tokenizer, Rules::Sanitizer, Rules::Uniquifier].freeze

    attr_reader :src, :rules

    def initialize(src:, rules: DEFAULT_RULES)
      @src = src
      @rules = rules.dup
      freeze
    end

    def call
      yield(rules) if block_given?
      rules.reduce(src) do |_src, rule|
        _src = rule.call(_src)
      end
    end
  end
end
