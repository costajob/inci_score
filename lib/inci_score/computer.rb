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
      @response ||= Response::new(components: components,
                                  unrecognized: @unrecognized,
                                  score: score,
                                  valid: valid?)
    end

    private

    def score
      return @score if @score
      warn "there are unrecognized ingredients!" unless valid?
      @score = Scorer::new(components.values).call
    end

    def ingredients
      @ingredients ||= Normalizer::new(src: @src).call
    end

    def components
      @components ||= Hash[ingredients.map do |ingredient|
        Recognizer::new(ingredient: ingredient, catalog: @catalog).call do |i|
          @unrecognized << i
        end
      end.compact]
    end

    def valid?
      @valid ||= @unrecognized.size / (ingredients.size / 100.0) <= TOLERANCE
    end
  end
end
