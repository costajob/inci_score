require 'inci_score/levenshtein'

module InciScore
  class Matcher
    TOLERANCE = 3

    attr_reader :distance, :component

    def initialize(ingredient)
      @ingredient = ingredient
      @distance = ingredient.size
    end

    def update!(component)
      distance = @ingredient.distance(component)
      return if @distance <= distance
      @component = component
      @distance = distance
    end

    def call
      return @component if valid?
      yield(@ingredient) if block_given?
    end

    private

    def valid?
      return false unless @component
      @distance <= TOLERANCE
    end
  end
end
