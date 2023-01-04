# frozen_string_literal: true

require 'inci_score/levenshtein'

module InciScore
  module Refinements
    refine(String) do
      def distance_utf8(t)
        InciScore::Levenshtein.new(self, t).call
      end

      def distance(t)
        InciScore::LevenshteinC.new.call(self.downcase, self.size, t.downcase, t.size)
      end
    end
  end
end
