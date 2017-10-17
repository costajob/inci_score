module InciScore
  class Ingredient
    SLASH_RULE = /(?<!ate)\//
    PARENTHESIS = %w[( ) [ ]]
    DETAILS_RULE = /(\(.+\)|\[.+\])/

    attr_reader :raw

    def initialize(raw)
      @raw = raw
      @tokens = raw.split(SLASH_RULE).map(&:strip)
    end

    def name
      return @tokens.first unless parenthesis?
      raw.sub(DETAILS_RULE, "").strip
    end

    def synonims
      @tokens[1, @tokens.size]
    end

    def details
      return unless parenthesis?
      raw.match(DETAILS_RULE)[1].delete(PARENTHESIS.join("|"))
    end

    private def parenthesis?
      PARENTHESIS.each_slice(2).any? do |pair|
        pair.all? { |p| raw.index(p) }
      end
    end
  end
end
