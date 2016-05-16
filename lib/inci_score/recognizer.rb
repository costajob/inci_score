require 'inci_score/config'
require 'inci_score/levenshtein'

module InciScore
  class Recognizer
    DEFAULTS = %w[by_key by_distance by_digits by_tokens]
    TOLERANCE = 3
    MEANINGFUL_DIGITS = 7
    UNMATCHABLE = %w[extract oil sodium acid sulfate]
    SEPARATOR = "/".freeze

    def initialize(options = {})
      @ingredient = options.fetch(:ingredient)
      @catalog = options.fetch(:catalog) { Config::catalog }
      @components = @catalog.keys
      @rules = options[:rules] || DEFAULTS
    end

    def call
      @component = apply_rules
      return [@component, @catalog[@component]] if @component
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
      initial = @ingredient[0]
      min_distance = @components.reduce([nil, @ingredient.size]) do |min, component|
        next min unless component.start_with?(initial)
        match = (n = component.index(SEPARATOR)) ? component[0, n] : component
        d = @ingredient.distance(match)
        min = [component, d] if d < min[1]
        min
      end
      return if min_distance[1] > TOLERANCE || min_distance[1] >= (@ingredient.size-1)
      min_distance[0]
    end

    def by_digits
      return if @ingredient.size < TOLERANCE
      digits = @ingredient[0,MEANINGFUL_DIGITS]
      @components.detect do |component| 
        component.match(/^#{Regexp::escape(digits)}/)
      end
    end

    def by_tokens
      tokens = (@ingredient.split(" ") - UNMATCHABLE).reject { |t| t.size < TOLERANCE }.sort_by!(&:size).reverse!
      tokens.each do |token|
        @components.each do |component| 
          return component if component.match(/\b#{Regexp::escape(token)}\b/)
        end
      end
      nil
    end
  end
end
