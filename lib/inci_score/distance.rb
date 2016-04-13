require 'inci_score/fuzziness'

using InciScore::Fuzziness

module InciScore
  class Distance
    attr_reader :score

    MAX = 10
    MIN = 1

    def initialize(s, t)
      @s = s.downcase
      @t = t.downcase
      @levenshtein = @s.levenshtein(@t)
      @score = fetch_score
    end

    private

    def fetch_score
      return MAX if @levenshtein.zero?
      return MIN if compute <= 0
      compute
    end

    def compute
      @computation ||= MAX - @levenshtein + assonance
    end

    def assonance
      return MIN if @s.assonant?(@t)
      0
    end
  end
end
