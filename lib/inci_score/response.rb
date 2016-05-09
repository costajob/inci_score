module InciScore
  class Response
    attr_reader :components, :score, :unrecognized, :valid

    def initialize(options = {})
      @components = options.fetch(:components) { [] }
      @score = options.fetch(:score) { 0.0 }
      @unrecognized = options.fetch(:unrecognized) { [] }
      @valid = options.fetch(:valid) { false }
    end

    def to_h
      { components: @components, score: @score, unrecognized: @unrecognized, valid: @valid }
    end
  end
end
