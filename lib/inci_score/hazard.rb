module InciScore
  class Hazard
    attr_reader :score

    def initialize(value, weight)
      @value = value
      @weight = weight
      @score = compute_score
    end

    private

    def compute_score
      (@value - @weight).tap do |s|
        return 0.0 if s < 0
      end
    end
  end
end
