module InciScore
  class Ingredient
    SLASH = "/"
    SLASH_RULE = /(?<!ate)\//
    PARENTHESIS = %w[( ) [ ]]
    DETAILS_RULE = /(\(.+\)|\[.+\])/

    def self.bulk(tokens)
      tokens.map { |raw| new(raw) }
    end

    def initialize(raw)
      @raw = raw
      @tokens = raw.split(SLASH_RULE).map(&:strip)
    end

    def to_s
      values.join(SLASH)
    end

    def values
      @values ||= synonims.unshift(name).compact
    end

    private def name
      return @tokens.first unless parenthesis?
      @raw.sub(DETAILS_RULE, "").strip
    end

    private def synonims
      @tokens[1, @tokens.size]
    end

    private def details
      return unless parenthesis?
      @raw.match(DETAILS_RULE)[1].delete(PARENTHESIS.join("|"))
    end

    private def parenthesis?
      PARENTHESIS.each_slice(2).any? do |pair|
        pair.all? { |p| @raw.index(p) }
      end
    end
  end
end
