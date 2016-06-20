require 'inci_score/config'
require 'inci_score/normalizer'
require 'inci_score/recognizer'
require 'inci_score/scorer'
require 'inci_score/response'

module InciScore
  class Computer
    TOLERANCE = 30.0

    def initialize(options = {})
      @catalog = options.fetch(:catalog) { Config::catalog }
      @processor = options.fetch(:processor) { -> { options[:src] } }
      @src = @processor.call
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
      @score ||= begin
                   warn "there are unrecognized ingredients!" unless valid?
                   Scorer.new(components.map(&:last)).call
                 end
    end

    def ingredients
      @ingredients ||= Normalizer.new(src: @src).call
    end

    def components
      @components ||= ingredients.map do |ingredient|
        Recognizer.new(src: ingredient, catalog: @catalog).call.tap do |component|
          @unrecognized << ingredient unless component
        end
      end.compact
    end

    def valid?
      @valid ||= @unrecognized.size / (ingredients.size / 100.0) <= TOLERANCE
    end
  end
end
