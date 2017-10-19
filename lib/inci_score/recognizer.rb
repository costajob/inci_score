require "inci_score/recognizer_rules"

module InciScore
  class Recognizer
    DEFAULT_RULES = [Rules::Key, Rules::Levenshtein, Rules::Digits, Rules::Tokens]

    Component = Struct.new(:name, :hazard)

    attr_reader :applied

    def initialize(ingredient, catalog, rules = DEFAULT_RULES)
      @ingredient = ingredient
      @catalog = catalog
      @rules = rules
      @applied = []
    end

    def call(precise = false)
      return if @ingredient.to_s.empty?
      component = find_component(precise)
      return unless component
      Component.new(component, @catalog[component])
    end 

    private def find_component(precise)
      @rules.reduce(nil) do |component, rule|
        break(component) if component
        applied << rule
        apply(rule, precise)
      end
    end

    private def apply(rule, precise)
      return rule.call(@ingredient.to_s, @catalog) unless precise
      @ingredient.values.map do |value|
        rule.call(value, @catalog)
      end.find(&:itself)
    end
  end
end
