# frozen_string_literal: true

require 'inci_score/ingredient'
require 'inci_score/normalizer'
require 'inci_score/recognizer'
require 'inci_score/response'
require 'inci_score/scorer'

module InciScore
  class Computer
    TOLERANCE = 30.0
    PERCENT = 100.0

    attr_reader :src, :catalog, :tolerance, :rules, :ingredients, :components, :unrecognized

    def initialize(src:, catalog: Catalog.fetch, tolerance: TOLERANCE, rules: Normalizer::DEFAULT_RULES)
      @unrecognized = []
      @src = src
      @catalog = catalog
      @tolerance = Float(tolerance)
      @rules = rules
      @ingredients = Normalizer.new(src: src, rules: rules).call
      @components = fetch_components
      freeze
    end

    def call
      Response.new(components: components.map(&:name),
                   unrecognized: unrecognized,
                   score: score,
                   valid: valid?)
    end

    def score
      Scorer.new(components.map(&:hazard)).call
    end

    def valid?
      unrecognized.size / (ingredients.size / PERCENT) <= tolerance
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
