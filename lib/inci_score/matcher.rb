require 'inci_score/levenshtein'

module InciScore
  class Matcher
    TOLERANCE = 3

    attr_reader :distance, :component, :unrecognized

    def initialize(ingredient, unrecognized = [])
      @ingredient = ingredient
      @distance = ingredient.size
      @unrecognized = unrecognized
    end

    def update!(component)
      distance = @ingredient.distance(component)
      return if @distance <= distance
      @component = component
      @distance = distance
    end

    def call
      return @component if valid?
      manage_unrecognized
    end

    private

    def manage_unrecognized
      return if @unrecognized.include? @ingredient
      @unrecognized << @ingredient 
      nil
    end

    def valid?
      return false unless @component
      @distance <= TOLERANCE
    end
  end
end
