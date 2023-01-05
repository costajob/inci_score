# frozen_string_literal: true

module InciScore
  class Ingredient
    SLASH_RULE = /(?<!ate)\//.freeze
    PARENTHESIS = %w[( ) [ ]].freeze
    PARENTHESIS_RULE = /(\(.+\)|\[.+\])/.freeze

    attr_reader :raw, :values

    def initialize(raw)
      @raw = raw.to_s
      @values = fetch_values.uniq
      freeze
    end

    private

    def fetch_values
      [raw].tap do |vals|
        if parenthesis?
          parenthesis = PARENTHESIS.join
          parenthesis_values = raw.match(PARENTHESIS_RULE).captures.map { |c| c.delete(parenthesis) }
          deparenthesized = raw.sub(PARENTHESIS_RULE, '').sub(/\s{2,}/, ' ').strip
          vals << deparenthesized
          vals.concat(parenthesis_values)
        else
          vals.concat(raw.split(SLASH_RULE).map(&:strip))
        end
      end
    end

    def parenthesis?
      PARENTHESIS.each_slice(2).any? do |pair|
        pair.all? { |p| raw.index(p) }
      end
    end
  end
end
