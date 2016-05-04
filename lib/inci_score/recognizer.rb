module InciScore
  class Recognizer
    SEPARATOR = "/".freeze 
    MEANINGFUL_DIGITS = 6

    attr_reader :component

    def initialize(ingredient, catalog)
      @ingredient = ingredient
      @token = token
      @digits = @ingredient[0,MEANINGFUL_DIGITS]
      @component = compute_by_token(catalog) || compute_by_digits(catalog)
    end

    private

    def compute_by_token(catalog)
      compute(catalog, /^#{Regexp::escape(@token)}/)
    end

    def compute_by_digits(catalog)
      return if @digits.size < MEANINGFUL_DIGITS
      compute(catalog, /#{Regexp::escape(@digits)}/)
    end

    def compute(catalog, regexp)
      catalog.keys.detect { |component| component.match(regexp) }
    end

    def token
      @ingredient.split(separator).first
    end

    def separator
      return SEPARATOR if @ingredient.index(SEPARATOR)
      " "
    end
  end
end
