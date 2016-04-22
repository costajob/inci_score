require 'inci_score/levenshtein'

module InciScore
  module Fuzziness
    refine String do
      def distance(t)
        Levenshtein::new(self, t).call
      end
    end
  end
end
