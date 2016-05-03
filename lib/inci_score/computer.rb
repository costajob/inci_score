require 'inci_score/parser'
require 'inci_score/tesseract'
require 'inci_score/normalizer'
require 'inci_score/matcher'

module InciScore
  class Computer
    TOLERANCE = 30.0

    class UnrecognizedIngredientsError < StandardError; end

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

    def call
      fail UnrecognizedIngredientsError, @unrecognized.inspect unless valid?
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

    private

    def valid?
      total = ingredients.size
      unfound = total - components.size
      percent = unfound / (total / 100.0) 
      percent <= TOLERANCE
    end

    def components_to_scan(ingredient)
      first_char = ingredient[0]
      (@catalog.keys - @recognized).select do |component|
        component.start_with?(first_char)
      end
    end

    def find(ingredient)
      return ingredient if @catalog[ingredient]
      matcher = Matcher::new(ingredient, @unrecognized)
      components_to_scan(ingredient).each do |component|
        matcher.update!(component)
        return component if matcher.distance.zero?
      end
      matcher.call
    end
  end
end
