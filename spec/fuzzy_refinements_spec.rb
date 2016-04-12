require 'spec_helper'
require 'inci_score/fuzzy_refinements'
using InciScore::FuzzyRefinements

describe InciScore::FuzzyRefinements do
  it 'must calculate edit distance' do
    'elvis'.levenshtein('Elviz').must_equal 2
  end

  it 'must calculate metaphone' do
    'BOTTLE'.metaphone.must_equal 'battle'.metaphone
  end
end
