require 'inci_score/recognizer_rules'

module InciScore
  class Recognizer
    DEFAULT_RULES = Rules.constants - [:Base]

    def initialize(src, catalog, rules = DEFAULT_RULES)
      @src = src
      @catalog = catalog
      @rules = rules
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
