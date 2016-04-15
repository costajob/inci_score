require 'inci_score/fuzziness'

using InciScore::Fuzziness

module InciScore
  class Distance
    attr_reader :score

    MAX = 10
    MIN = 0.5

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
      @score ||= MAX - @levenshtein - assonance
    end

    def assonance
      @assonance = @s.assonant?(@t) ? 0 : MIN
    end
  end
end
