require 'inci_score/normalizer'
require 'inci_score/recognizer'
require 'inci_score/scorer'
require 'inci_score/response'

module InciScore
  class Computer
    TOLERANCE = 30.0

    def initialize(src:, catalog:, tolerance: TOLERANCE, rules: Normalizer::DEFAULT_RULES, precise: false)
      @src = src
      @catalog = catalog
      @tolerance = Float(tolerance)
      @rules = rules
      @unrecognized = []
      @precise = precise
    end

    def call
      @response ||= Response.new(components: components.map(&:first),
                                 unrecognized: @unrecognized,
                                 score: score,
                                 valid: valid?)
    end

    private def score
      Scorer.new(components.map(&:last)).call
    end

    private def ingredients
      @ingredients ||= Normalizer.new(src: @src, rules: @rules).call
    end

    private def components
      @components ||= ingredients.map do |ingredient|
        Recognizer.new(ingredient, @catalog).call(@precise).tap do |component|
          @unrecognized << ingredient unless component
        end
      end.compact
    end

    private def valid?
      @unrecognized.size / (ingredients.size / 100.0) <= @tolerance
    end
  end
end
