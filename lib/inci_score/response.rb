require "json"

module InciScore
  class Response
    attr_reader :components, :score, :unrecognized, :valid

    def initialize(options = {})
      @components = options.fetch(:components) { [] }
      @score = options.fetch(:score) { 0.0 }
      @unrecognized = options.fetch(:unrecognized) { [] }
      @valid = options.fetch(:valid) { false }
    end

    def to_json
      { components: @components, unrecognized: @unrecognized, score: @score, valid: @valid }.to_json
    end

    def to_s
      %Q{
TOTAL SCORE:
      \t#{@score}
VALID STATE:
      \t#{@valid}
COMPONENTS:
      #{@components.map { |c| "\t#{c}" }.join("\n")}
UNRECOGNIZED:
      #{@unrecognized.map { |c| "\t#{c}" }.join("\n")}
      }
    end
  end
end
