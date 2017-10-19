require "inci_score/score"

module InciScore
  class Scorer
    HAZARD_PERCENT = 25
    WEIGHT_FACTOR = 5

    def initialize(hazards)
      @hazards = Array(hazards)
      @size = @hazards.size
    end

    def call
      return 0 if @hazards.empty?
      (100 - avg * HAZARD_PERCENT).round(4)
    end

    private def avg
      avg_weighted / @size.to_f
    end

    private def avg_weighted
      return @hazards.reduce(&:+) if same_hazard?
      weighted.reduce(0.0) do |acc,score| 
        acc += score.value
      end
    end

    private def same_hazard?
      @hazards.uniq.size == 1
    end

    private def weighted
      @hazards.each_with_index.map do |h,i|
        Score.new(h, weight(i))
      end
    end

    private def weight(index)
      Math.log(index+1, @size * WEIGHT_FACTOR)
    end
  end
end
