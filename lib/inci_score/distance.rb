require 'inci_score/fuzziness'

module InciScore
  using Fuzziness
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

  module Fuzziness
    refine String do
      def distance(t)
        Distance::new(self, t).score
      end
    end
  end
end
