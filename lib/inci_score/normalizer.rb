require 'inci_score/normalizer_rules'

module InciScore
  class Normalizer
    DEFAULT_RULES = Rules.constants - [:Base]

    attr_reader :src

    def initialize(options = {})
      @src = options[:src] || fail(ArgumentError, 'missing src')
      @rules = options.fetch(:rules) { DEFAULT_RULES }
    end

    def call
      @rules.reduce(@src) do |src, name|
        rule = Rules.const_get(name).new(src)
        src = rule.call
      end
    end
  end
end
