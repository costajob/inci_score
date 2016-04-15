module InciScore
  class Inci
    class MissingIngredients < ArgumentError; end

    def initialize(options = {})
      @ingredients = options[:ingredients].to_s
      @components = options[:components].to_h
    end

    private

    def normalize_ingredients
    end
  end
end
