require 'inci_score/levenshtein'
require 'inci_score/metaphone'

module InciScore
  module FuzzyRefinements
    refine String do
      def levenshtein(t)
        Levenshtein::new(self, t).call
      end

      def metaphone
        Metaphone::new(self).call
      end
    end
  end
end
