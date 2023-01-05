# frozen_string_literal: true

module InciScore
  class Recognizer
    DEFAULT_RULES = [Rules::Key, Rules::Levenshtein, Rules::Hazard, Rules::Prefix, Rules::Tokens].freeze

    Component = Struct.new(:name, :hazard)

    attr_reader :ingredient, :rules, :applied

    def initialize(ingredient, rules = DEFAULT_RULES)
      @ingredient = Ingredient.new(ingredient)
      @rules = rules
      @applied = []
      freeze
    end

    def call
      return if ingredient.to_s.empty?
      component = find_component
      return unless component
      Component.new(component, Config::CATALOG[component])
    end

    private

    def find_component
      rules.reduce(nil) do |component, rule|
        break(component) if component
        applied << rule
        apply(rule)
      end
    end

    def apply(rule)
      ingredient.values.map do |value|
        rule.call(value)
      end.find(&:itself)
    end
  end
end
