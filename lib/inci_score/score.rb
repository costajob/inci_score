# frozen_string_literal: true

module InciScore
  class Score
    attr_reader :value, :hazard, :weight

    def initialize(hazard, weight)
      @hazard = hazard
      @weight = weight
      @value = compute
      freeze
    end

    private

    def compute
      (hazard - weight).tap do |s|
        return 0.0 if s < 0
      end
    end
  end
end
