require 'inci_score/config'
require 'inci_score/recognizer_rules'

module InciScore
  class Recognizer
    DEFAULT_RULES = Rules.constants - [:Base]

    def initialize(options = {})
      @src = options.fetch(:src)
      @catalog = options.fetch(:catalog) { Config::catalog }
      @rules = options[:rules] || DEFAULT_RULES
    end

    def call
      @component = apply_rules
      return [@component, @catalog[@component]] if @component
    end 

    private

    def apply_rules
      @rules.reduce(nil) do |component, name|
        rule = Rules.const_get(name).new(@src, @catalog)
        component || rule.call
      end
    end
  end
end
