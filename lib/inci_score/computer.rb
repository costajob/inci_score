require 'inci_score/config'
require 'inci_score/tesseract'
require 'inci_score/normalizer'
require 'inci_score/recognizer'
require 'inci_score/scorer'
require 'inci_score/response'

module InciScore
  class Computer
    TOLERANCE = 30.0

    def initialize(options = {})
      @src = options[:src]
      @catalog = options.fetch(:catalog) { Config::catalog }
      @processor = options.fetch(:processor) { Tesseract::new(src: @src) }
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @processor.call) }
      @unrecognized = []
    end

    def call
      @response ||= Response::new(valid: valid?,
                                  components: components,
                                  unrecognized: @unrecognized,
                                  score: score)
    end

    private

    def score
      return @score if @score
      warn "there are unrecognized ingredients!" unless valid?
      @score = Scorer::new(components.values).call
    end

    def ingredients
      @ingredients ||= @normalizer.call
    end

    def components
      @components ||= Hash[ingredients.map do |ingredient|
        Recognizer::new(ingredient: ingredient, catalog: @catalog).call do |i|
          @unrecognized << i
        end
      end.tap { |c| c.compact! }]
    end

    def valid?
      @valid ||= begin
                   total = ingredients.size
                   unfound = total - components.size
                   percent = unfound / (total / 100.0) 
                   percent <= TOLERANCE
                 end
    end
  end
end
