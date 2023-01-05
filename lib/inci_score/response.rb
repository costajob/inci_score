# frozen_string_literal: true

require 'oj'

module InciScore
  class Response
    attr_reader :components, :score, :unrecognized, :precision

    def initialize(options = {})
      @components = options.fetch(:components) { [] }
      @score = options.fetch(:score) { 0.0 }
      @unrecognized = options.fetch(:unrecognized) { [] }
      @precision = options.fetch(:precision) { 0 }
      freeze
    end

    def to_json
      data = { components: components.map(&:to_h), unrecognized: unrecognized, score: score, precision: precision }.freeze
      Oj.dump(data, mode: :compat)
    end

    def to_s
      [score_str, precision_str, components_str, unrecognized_str].join
    end

    private

    def score_str
      %Q{
TOTAL SCORE:
      \t#{score}}
    end

    def precision_str
      %Q{
PRECISION:
      \t#{precision}}
    end

    def components_str
      return '' if components.empty?
      %Q{
COMPONENTS:
      \t#{components.map { |c| "#{c.name} (#{c.hazard})" }.join(', ')}}
    end

    def unrecognized_str
      return '' if unrecognized.empty?
      %Q{
UNRECOGNIZED:
      \t#{unrecognized.join(', ')}}
    end
  end
end
