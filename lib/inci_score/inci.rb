require 'inci_score/parser'
require 'inci_score/distance'
require 'inci_score/tesseract'
require 'inci_score/normalizer'

module InciScore
  using Fuzziness
  class Inci
    def initialize(options = {})
      @src = options.fetch(:src) { fail ArgumentError, "missing src" }
      @catalog = options.fetch(:catalog) { Parser::new.call }
      @processor = options.fetch(:processor) { Tesseract::new(src: @src) }
      @normalizer = options.fetch(:normalizer) { Normalizer::new(src: @processor.call) }
    end

    def ingredients
      @ingredients ||= @normalizer.call
    end
  end
end
