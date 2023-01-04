# frozen_string_literal: true

require 'oj'

module InciScore
  class Response
    attr_reader :components, :score, :unrecognized, :valid, :precision

    def initialize(options = {})
      @components = options.fetch(:components) { [] }
      @score = options.fetch(:score) { 0.0 }
      @unrecognized = options.fetch(:unrecognized) { [] }
      @valid = options.fetch(:valid) { false }
      @precision = options.fetch(:precision) { 0 }
      freeze
    end

    def to_json
      data = { components: components.map(&:to_h), unrecognized: unrecognized, score: score, valid: valid, precision: precision }.freeze
      Oj.dump(data, mode: :compat)
    end

    def to_s
      %Q{
TOTAL SCORE:
      \t#{score}
VALID STATE:
      \t#{valid}
PRECISION:
      \t#{precision}
COMPONENTS:
      \t#{components.map { |c| "#{c.name} (#{c.hazard})" }.join(', ')}
UNRECOGNIZED:
      \t#{unrecognized.join(', ')}
      }
    end
  end
end
