require "inci_score/ingredient"
require "inci_score/normalizer"
require "inci_score/recognizer"
require "inci_score/response"
require "inci_score/scorer"

module InciScore
  class Computer
    TOLERANCE = 30.0
    PERCENT = 100.0

    def initialize(src:, catalog:, 
                   tolerance: TOLERANCE, 
                   rules: Normalizer::DEFAULT_RULES, 
                   precise: false)
      @src = src
      @catalog = catalog
      @tolerance = Float(tolerance)
      @rules = rules
      @unrecognized = []
      @precise = precise
    end

    def call
      @response ||= Response.new(components: components.map(&:name),
                                 unrecognized: @unrecognized,
                                 score: score,
                                 valid: valid?)
    end

    private def score
      Scorer.new(components.map(&:hazard)).call
    end

    private def ingredients
      @ingredients ||= begin
                         tokens = Normalizer.new(src: @src, rules: @rules).call
                         Ingredient.bulk(tokens)
                       end
    end

    private def components
      @components ||= ingredients.map do |ingredient|
        Recognizer.new(ingredient, @catalog).call(@precise).tap do |component|
          @unrecognized << ingredient unless component
        end
      end.compact
    end

    private def valid?
      @unrecognized.size / (ingredients.size / PERCENT) <= @tolerance
    end
  end
end
