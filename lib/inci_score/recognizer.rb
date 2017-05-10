require "inci_score/recognizer_rules"

module InciScore
  class Recognizer
    DEFAULT_RULES = [Rules::Key, Rules::Levenshtein, Rules::Digits, Rules::Tokens]

    def initialize(src, catalog, rules = DEFAULT_RULES)
      @src = src
      @catalog = catalog
      @rules = rules
    end

    def call(precise = false)
      @component = @rules.reduce(nil) do |component, rule|
        break(component) if component
        yield(rule) if block_given?
        rule.call(@src, @catalog, precise)
      end
      [@component, @catalog[@component]] if @component
    end 
  end
end
