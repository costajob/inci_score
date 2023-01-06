# frozen_string_literal: true

module InciScore
  class Recognizer
    DEFAULT_RULES = [Rules::Key, Rules::Levenshtein, Rules::Hazard, Rules::Prefix, Rules::Tokens].freeze
    PRECISION_BASE = 4

    attr_reader :ingredient, :rules, :applied
    attr_accessor :found

    def initialize(ingredient, rules = DEFAULT_RULES)
      @ingredient = Ingredient.new(ingredient)
      @rules = rules
      @applied = []
      @found = false
    end

    def call
      return if ingredient.to_s.empty?
      find_component.tap do |c|
        self.found = true if c
      end
    end

    def precision
      return 0.0 unless found
      rule = applied.last
      index = rules.index(rule) + PRECISION_BASE
      ratio = Math.log(index, PRECISION_BASE)
      (100 / ratio).round(2)
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
