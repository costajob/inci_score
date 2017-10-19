module InciScore
  class Score
    attr_reader :value

    def initialize(hazard, weight)
      @hazard = hazard
      @weight = weight
      @value = compute
    end

    private def compute
      (@hazard - @weight).tap do |s|
        return 0.0 if s < 0
      end
    end
  end
end
