require 'inci_score/fuzziness'

module InciScore
  using Fuzziness
  class Distance
    attr_reader :score

    MAX = 10
    MIN = 0.5

    def initialize(s, t, check_assonance = false)
      @s = s.downcase
      @t = t.downcase
      @check_assonance = check_assonance
      @levenshtein = @s.levenshtein(@t)
      @score = fetch_score
    end

    private

    def fetch_score
      return MAX if @levenshtein.zero?
      return MAX if compute > MAX
      return MIN if compute < MIN
      compute
    end

    def compute
      @score ||= MAX - @levenshtein + assonance
    end

    def assonance
      return 0 unless @check_assonance
      @assonance = @s.assonant?(@t) ? MIN : 0
    end
  end

  module Fuzziness
    refine String do
      def distance(t, check_assonance = false)
        Distance::new(self, t, check_assonance).score
      end
    end
  end
end
