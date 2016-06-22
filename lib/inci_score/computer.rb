require 'inci_score/catalog'
require 'inci_score/normalizer'
require 'inci_score/recognizer'
require 'inci_score/scorer'
require 'inci_score/response'

module InciScore
  class Computer
    TOLERANCE = 30.0

    def initialize(src, catalog = Catalog.fetch)
      @src = src
      @catalog = catalog
      @unrecognized = []
    end

    def call
      @response ||= Response.new(components: components.map(&:first),
                                 unrecognized: @unrecognized,
                                 score: score,
                                 valid: valid?)
    end

    private

    def score
      Scorer.new(components.map(&:last)).call
    end

    def ingredients
      @ingredients ||= Normalizer.new(src: @src).call
    end

    def components
      @components ||= ingredients.map do |ingredient|
        Recognizer.new(ingredient, @catalog).call.tap do |component|
          @unrecognized << ingredient unless component
        end
      end.compact
    end

    def valid?
      @unrecognized.size / (ingredients.size / 100.0) <= TOLERANCE
    end
  end
end
