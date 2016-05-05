require 'inci_score/parser'
require 'inci_score/tesseract'
require 'inci_score/normalizer'
require 'inci_score/matcher'
require 'inci_score/recognizer'
require 'inci_score/scorer'

module InciScore
  class Computer
    TOLERANCE = 30.0

    attr_reader :unrecognized

    def initialize(options = {})
      @src = options[:src]
      @catalog = options.fetch(:catalog) { Parser::by_yaml }
      @processor = options.fetch(:processor) { Tesseract::new(src: @src) }
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @processor.call) }
      @recognized = []
      @unrecognized = []
    end

    def call(scorer = Scorer)
      warn "there are unrecognized ingredients!" unless valid?
      hazards = @catalog.select { |k,v| components.include?(k) }.values
      scorer::new(hazards).call
    end

    def ingredients
      @ingredients ||= @normalizer.call
    end

    def components
      @components ||= ingredients.map do |ingredient|
        find(ingredient).tap do |found| 
          @recognized << found if found
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

    private

    def components_to_scan(ingredient)
      first_char = ingredient[0]
      (@catalog.keys - @recognized).select do |component|
        component.start_with?(first_char)
      end
    end

    def find(ingredient)
      return ingredient if @catalog[ingredient]
      matcher = Matcher::new(ingredient)
      components_to_scan(ingredient).each do |component|
        matcher.update!(component)
        return component if matcher.distance.zero?
      end
      matcher.call { |i| recognize(i) }
    end

    def recognize(ingredient)
      recognizer = Recognizer::new(ingredient: ingredient, catalog: @catalog)
      recognizer.call { |i| @unrecognized << i }
    end
  end
end
