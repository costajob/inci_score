# frozen_string_literal: true

module InciScore
  class Ingredient
    SLASH = '/'
    SLASH_RULE = /(?<!ate)\//.freeze
    PARENTHESIS = %w[( ) [ ]].freeze
    DETAILS_RULE = /(\(.+\)|\[.+\])/.freeze

    attr_reader :raw, :tokens, :values

    def initialize(raw)
      @raw = raw.to_s
      @tokens = @raw.split(SLASH_RULE).map(&:strip)
      @values ||= synonims.unshift(name).compact
      freeze
    end

    def to_s
      values.join(SLASH)
    end

    private

    def name
      return tokens.first unless parenthesis?
      raw.sub(DETAILS_RULE, '').strip
    end

    def synonims
      tokens[1, tokens.size].to_a
    end

    def parenthesis?
      PARENTHESIS.each_slice(2).any? do |pair|
        pair.all? { |p| raw.index(p) }
      end
    end
  end
end
