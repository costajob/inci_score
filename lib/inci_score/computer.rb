# frozen_string_literal: true

module InciScore
  class Computer
    TOLERANCE = 50.0
    DECIMALS = 2

    attr_reader :src, :rules, :ingredients, :components, :unrecognized, :precisions

    def initialize(src:, rules: Normalizer::DEFAULT_RULES)
      @unrecognized = []
      @precisions = []
      @src = src
      @rules = rules
      @ingredients = Normalizer.new(src: src, rules: rules).call
      @components = fetch_components
      freeze
    end

    def call
      Response.new(components: components,
                   unrecognized: unrecognized,
                   score: score,
                   precision: precision)
    end

    def score
      Scorer.new(components.map(&:hazard)).call.round(DECIMALS)
    end

    def precision
      (precisions.sum / ingredients.size).round(DECIMALS)
    end

    def valid?
      precision >= TOLERANCE
    end

    private

    def fetch_components
      ingredients.map do |ingredient|
        recognizer = Recognizer.new(ingredient)
        recognizer.call.tap do |component|
          precisions << recognizer.precision
          unrecognized << ingredient unless component
        end
      end.compact
    end
  end
end
