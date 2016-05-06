require 'inci_score/config'
require 'inci_score/tesseract'
require 'inci_score/normalizer'
require 'inci_score/recognizer'
require 'inci_score/scorer'

module InciScore
  class Computer
    TOLERANCE = 30.0

    attr_reader :unrecognized

    def initialize(options = {})
      @src = options[:src]
      @catalog = options.fetch(:catalog) { Config::catalog }
      @processor = options.fetch(:processor) { Tesseract::new(src: @src) }
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @processor.call) }
      @rules = options.fetch(:rules) { Recognizer::DEFAULTS }
      @unrecognized = []
    end

    def score
      return @score if @score
      warn "there are unrecognized ingredients!" unless valid?
      hazards = @catalog.select { |k,v| components.include?(k) }.values
      @score = Scorer::new(hazards).call
    end

    def ingredients
      @ingredients ||= @normalizer.call
    end

    def components
      @components ||= ingredients.map do |ingredient|
        Recognizer::new(ingredient: ingredient, catalog: @catalog, rules: @rules).call do |i|
          @unrecognized << i
        end
      end.tap { |c| c.compact! }
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
