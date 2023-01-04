# frozen_string_literal: true

module InciScore
  class Computer
    TOLERANCE = 30.0
    DECIMALS = 2

    attr_reader :src, :catalog, :rules, :ingredients, :components, :unrecognized

    def initialize(src:, catalog: Config::CATALOG, rules: Normalizer::DEFAULT_RULES)
      @unrecognized = []
      @src = src
      @catalog = catalog
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
      (100 - ((unrecognized.size / Float(ingredients.size)) * 100)).round(DECIMALS)
    end

    def valid?
      precision >= TOLERANCE
    end

    private

    def fetch_components
      ingredients.map do |ingredient|
        Recognizer.new(ingredient, catalog).call.tap do |component|
          unrecognized << ingredient unless component
        end
      end.compact
    end
  end
end
