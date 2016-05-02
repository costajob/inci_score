require 'inci_score/parser'
require 'inci_score/levenshtein'
require 'inci_score/tesseract'
require 'inci_score/normalizer'
require 'inci_score/matcher'

module InciScore
  class Computer
    def self.catalog
      @catalog ||= Parser::new.call
    end

    attr_reader :unrecognized

    def initialize(options = {})
      @src = options[:src]
      @catalog = options.fetch(:catalog) { self.class::catalog }
      @processor = options.fetch(:processor) { Tesseract::new(src: @src) }
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @processor.call) }
      @recognized = []
      @unrecognized = []
    end

    def ingredients
      @ingredients ||= @normalizer.call
    end

    def components
      @components ||= ingredients.map do |ingredient|
        find(ingredient).tap do |found| 
          @recognized << found
        end
      end.tap { |c| c.compact! }
    end

    private

    def components_to_scan
      @catalog.keys - @recognized
    end

    def find(ingredient)
      return ingredient if @catalog[ingredient]
      matcher = Matcher::new(ingredient, @unrecognized)
      components_to_scan.each do |component|
        distance = ingredient.distance(component)
        return component if distance.zero?
        matcher.update!(component, distance) 
      end
      matcher.call
    end
  end
end
