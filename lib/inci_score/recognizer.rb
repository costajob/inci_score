module InciScore
  class Recognizer
    DEFAULTS = %w[by_tokens by_digits] 
    TOKEN_MIN_SIZE = 3
    MEANINGFUL_DIGITS = 6

    def initialize(options = {})
      @ingredient = options.fetch(:ingredient)
      @digits = @ingredient[0,MEANINGFUL_DIGITS]
      @catalog = options.fetch(:catalog) { {} }.keys
      @rules = options.fetch(:rules) { DEFAULTS }
    end

    def call
      @component ||= apply_rules
    end 

    private

    def apply_rules
      @rules.reduce(false) { |acc,rule| acc || send(rule) }
    end

    def by_digits
      return if @digits.size < MEANINGFUL_DIGITS
      @catalog.detect { |component| component.match(/^#{Regexp::escape(@digits)}/) }
    end

    def by_tokens
      return if same_occurrency?
      occurrencies.max_by { |h,k| k }.to_a.first
    end

    def occurrencies
      @occurrencies ||= components.reduce(Hash::new(0)) do |acc,component|
        acc[component] += 1; acc
      end
    end

    def same_occurrency?
      return false if occurrencies.size == 1
      occurrencies.values.uniq.size == 1
    end

    def components
      tokens.map do |token|
        @catalog.select { |component| component.match(/#{Regexp::escape(token)}/) }
      end.flatten
    end

    def tokens
      @ingredient.split(' ').reject { |token| token.size < TOKEN_MIN_SIZE }
    end
  end
end
