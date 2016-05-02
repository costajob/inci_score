module InciScore
  class Matcher
    TOLERANCE = 3

    def initialize(ingredient, unrecognized = [])
      @ingredient = ingredient
      @distance = ingredient.size
      @unrecognized = unrecognized
    end

    def update!(component, distance)
      return if @distance <= distance
      @component = component
      @distance = distance
    end

    def call
      return @component if valid?
      @unrecognized << @ingredient
      nil
    end

    private

    def valid?
      @distance <= TOLERANCE
    end
  end
end
