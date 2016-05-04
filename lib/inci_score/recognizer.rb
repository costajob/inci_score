module InciScore
  class Recognizer
    SEPARATOR = "/".freeze 
    MEANINGFUL_DIGITS = 6

    attr_reader :component

    def initialize(ingredient, catalog)
      @ingredient = ingredient
      @first_token = first_token
      @component = compute(catalog)
    end

    private

    def compute(catalog)
      catalog.keys.detect { |component| component.match(/^#{@first_token}/) }
    end

    def first_token
      @ingredient.split(separator).first[0,MEANINGFUL_DIGITS]
    end

    def separator
      return SEPARATOR if @ingredient.index(SEPARATOR)
      " "
    end
  end
end
