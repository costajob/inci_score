# frozen_string_literal: true

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
