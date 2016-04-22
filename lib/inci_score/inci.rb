require 'inci_score/parser'
require 'inci_score/fuzziness'
require 'inci_score/tesseract'
require 'inci_score/normalizer'

module InciScore
  using Fuzziness
  class Inci
    class Match
      TOLERANCE = 4

      def initialize(ingredient, component = nil)
        @ingredient = ingredient
        @component = component
        @distance = ingredient.size
      end

      def update!(component, distance)
        return if @distance <= distance
        @component = component
        @distance = distance
      end

      def compute(unrecognized)
        return @component if valid?
        unrecognized << @ingredient
        nil
      end

      private

      def valid?
        @distance <= TOLERANCE
      end
    end

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
      match = Match::new(ingredient)
      components_to_scan.each do |component|
        distance = ingredient.distance(component)
        return component if distance.zero?
        match.update!(component, distance) 
      end
      match.compute(@unrecognized)
    end
  end
end
