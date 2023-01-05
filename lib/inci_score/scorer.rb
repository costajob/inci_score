# frozen_string_literal: true

module InciScore
  class Scorer
    HAZARD_RATIO = 25
    WEIGHT_FACTOR = 5

    attr_reader :hazards, :size

    def initialize(hazards)
      @hazards = Array(hazards)
      @size = @hazards.size
      freeze
    end

    def call
      return 0 if hazards.empty?
      (100 - avg * HAZARD_RATIO).round(4)
    end

    private

    def avg
      avg_weighted / size.to_f
    end

    def avg_weighted
      return hazards.sum if same_hazard?
      weighted.sum(&:value)
    end

    def same_hazard?
      hazards.uniq.size == 1
    end

    def weighted
      hazards.each_with_index.map do |h, i|
        Score.new(h, weight(i))
      end
    end

    def weight(index)
      Math.log(index+1, size * WEIGHT_FACTOR)
    end
  end
end
