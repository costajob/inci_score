require 'inci_score/levenshtein'
require 'inci_score/metaphone'

module InciScore
  module Fuzziness
    class Distance
      MAX = 100.0
      FACTOR = 1.15
      TOLERANCE = 7.5
      MIN = MAX / (FACTOR + TOLERANCE)

      attr_reader :score

      def initialize(levenshtein, assonance)
        @levenshtein = levenshtein.to_i
        @assonance = assonance.to_i
        @score = fetch_score
      end

      private

      def fetch_score
        return MAX if @levenshtein.zero?
        return MIN if compute <= 0
        compute
      end

      def compute
        (MAX/factor - tolerance).round(5)
      end

      def factor
        Math::log(@levenshtein) + FACTOR
      end

      def tolerance
        @assonance * TOLERANCE
      end
    end

    refine String do
      def levenshtein(t)
        Levenshtein::new(self, t).call
      end

      def metaphone
        Metaphone::new(self).call
      end

      def assonance(t)
        self.metaphone.levenshtein(t.metaphone)
      end

      def distance(t)
        l = self.downcase.levenshtein(t.downcase)
        a = self.assonance(t)
        Distance::new(l, a)
      end
    end
  end
end
