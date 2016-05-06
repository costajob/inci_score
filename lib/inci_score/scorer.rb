require 'inci_score/hazard'

module InciScore
  class Scorer
    HAZARD_PERCENT = 25
    WEIGHT_FACTOR = 3

    def initialize(hazards)
      @hazards = Array(hazards)
      @size = @hazards.size
    end

    def call
      100 - avg * HAZARD_PERCENT
    end

    private

    def avg
      weighted.reduce(0.0) do |acc,h| 
        acc += h.score
      end / @size.to_f
    end

    def weighted
      @hazards.each_with_index.map do |h,i|
        Hazard::new(h, weight(i))
      end
    end

    def weight(index)
      Math.log(index+1, @size * WEIGHT_FACTOR)
    end
  end
end
