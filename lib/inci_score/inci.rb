require 'inci_score/parser'
require 'inci_score/distance'
require 'inci_score/normalizer'

module InciScore
  using Fuzziness
  class Inci
    def initialize(options = {})
      @src = options.fetch(:src) { fail ArgumentError, "missing src" }
      @catalog = options.fetch(:catalog) { Parser::new.call }
      @processor = options.fetch(:processor) { -> { @src } }
      @ingredients = @processor.call
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @ingredients) }
    end
  end
end
