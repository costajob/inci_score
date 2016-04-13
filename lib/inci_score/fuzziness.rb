require 'inci_score/levenshtein'
require 'inci_score/metaphone'

module InciScore
  module Fuzziness
    refine String do
      def levenshtein(t)
        Levenshtein::new(self, t).call
      end

      def metaphone
        Metaphone::new(self).call
      end

      def assonant?(t)
        self.metaphone == t.metaphone
      end
    end
  end
end
