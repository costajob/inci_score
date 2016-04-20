require 'inci_score/parser'
require 'inci_score/distance'
require 'inci_score/tesseract'
require 'inci_score/normalizer'

module InciScore
  using Fuzziness
  class Inci
    def self.catalog
      @catalog ||= Parser::new.call
    end

    attr_reader :unrecognized

    def initialize(options = {})
      @src = options[:src]
      @catalog = options.fetch(:catalog) { self.class::catalog }
      @processor = options.fetch(:processor) { Tesseract::new(src: @src) }
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @processor.call) }
      @except = []
      @unrecognized = []
    end

    def ingredients
      @ingredients ||= @normalizer.call
    end

    def components
      @components ||= ingredients.map do |ingredient|
        find(ingredient).tap do |found| 
          @except << found
        end
      end.tap { |c| c.compact! }
    end

    private

    def find(ingredient)
      return ingredient if @catalog[ingredient]
      found = [nil, 0]
      components = @catalog.keys.clone - @except
      until components.empty? do
        component = components.shift
        d = ingredient.distance(component)
        return component if d == Distance::MAX
        found = [component, d] if found[1] < d
      end
      if found[1] >= ingredient.size
        @unrecognized << ingredient
        return nil
      end
      found[0]
    end
  end
end
