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

    def initialize(options = {})
      @src = options[:src]
      @catalog = options.fetch(:catalog) { self.class::catalog }
      @processor = options.fetch(:processor) { Tesseract::new(src: @src) }
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @processor.call) }
    end

    def ingredients
      @ingredients ||= @normalizer.call
    end

    def components(msg = :find)
      @components ||= ingredients.map do |ingredient|
        send(msg, ingredient)
      end
      @components.compact!
      @components.reject!(&:empty?)
      @components
    end

    def scores
      components.map { |ingredient| @catalog[ingredient] }
    end

    private

    def find_exp(ingredient)
      return ingredient if @catalog[ingredient]
      found = [nil, 0]
      @catalog.keys.each do |component|
        d = ingredient.distance(component)
        return component if d == Distance::MAX
        found = [component, d] if found[1] < d
      end
      found[0]
    end

    def find(ingredient)
      return ingredient if @catalog[ingredient]
      found = [nil, 0]
      @catalog.keys.each do |component|
        d = ingredient.distance(component)
        return component if d == Distance::MAX
        found = [component, d] if found[1] < d
      end
      found[0]
    end
  end
end
