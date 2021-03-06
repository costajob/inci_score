require "inci_score/recognizer_rules"

module InciScore
  class Recognizer
    DEFAULT_RULES = [Rules::Key, Rules::Levenshtein, Rules::Digits, Rules::Tokens]

    Component = Struct.new(:name, :hazard)

    attr_reader :applied

    def initialize(ingredient, catalog, rules = DEFAULT_RULES, wrapper = Ingredient)
      @ingredient = wrapper.new(ingredient)
      @catalog = catalog
      @rules = rules
      @applied = []
    end

    def call
      return if @ingredient.to_s.empty?
      component = find_component
      return unless component
      Component.new(component, @catalog[component])
    end 

    private def find_component
      @rules.reduce(nil) do |component, rule|
        break(component) if component
        applied << rule
        apply(rule)
      end
    end

    private def apply(rule)
      @ingredient.values.map do |value|
        rule.call(value, @catalog)
      end.find(&:itself)
    end
  end
end
