require 'inci_score/levenshtein'

module InciScore
  class Recognizer
    DEFAULTS = %w[by_key by_long_digits by_distance by_tokens by_short_digits]
    TOLERANCE = 3
    SHORT_DIGITS = 5
    LONG_DIGITS = 10

    def initialize(options = {})
      @ingredient = options.fetch(:ingredient)
      @catalog = options.fetch(:catalog) { {} }
      @components = @catalog.keys
      @rules = options.fetch(:rules) { DEFAULTS }
    end

    def call
      @component = apply_rules
      return @component if @component
      yield(@ingredient) if block_given?
      nil
    end 

    private

    def apply_rules
      @rules.reduce(false) do |acc,rule| 
        acc || send(rule)
      end
    end

    def by_key
      return @ingredient if @catalog.has_key?(@ingredient)
    end

    def by_distance
      min = distances.min_by { |d| d.last }
      return if invalid_distance?(min.last)
      min.first
    end

    def invalid_distance?(d)
      d > TOLERANCE || d >= @ingredient.size 
    end

    def distances
      @components.map do |component|
        [component, @ingredient.distance(component)]
      end
    end

    def by_short_digits
      by_digits(SHORT_DIGITS)
    end

    def by_long_digits
      by_digits(LONG_DIGITS)
    end

    def by_digits(n)
      return if @ingredient.size < n
      digits = @ingredient[0,n]
      @components.detect do |component| 
        component.match(/^#{Regexp::escape(digits)}/)
      end
    end

    def by_tokens
      return @component if first_matching_token
      return if same_occurrency?
      occurrencies.max_by { |h,k| k }.to_a.first
    end

    def occurrencies
      @occurrencies ||= components_by_token.reduce(Hash::new(0)) do |acc,component|
        acc[component] += 1; acc
      end
    end

    def same_occurrency?
      return false if occurrencies.size == 1
      occurrencies.values.uniq.size == 1
    end

    def first_matching_token
      @component = components_by_token.uniq.detect do |component|
        tokens.include?(component)
      end
    end

    def components_by_token
      @components_by_token ||= tokens.map do |token|
        @components.select do |component|
          component.match(/#{Regexp::escape(token)}/)
        end
      end.flatten
    end

    def tokens
      @tokens ||= @ingredient.split(' ').reject { |token| token.size < TOLERANCE }
    end
  end
end
