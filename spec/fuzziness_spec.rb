require 'spec_helper'
require 'inci_score/distance'

using InciScore::Fuzziness

describe InciScore::Fuzziness do
  it 'must calculate edit distance' do
    'elvis'.levenshtein('Elviz').must_equal 2
  end

  it 'must calculate metaphone' do
    'BOTTLE'.metaphone.must_equal 'battle'.metaphone
  end

  it 'must check assonance' do
    assert 'bottle'.assonant?('battle')
  end

  it 'must return a distance object' do
    'bottle'.distance('battle').must_be_instance_of InciScore::Distance
  end

  it 'must compute distance' do
    'bottle'.distance('battle').score.must_equal 9
  end
end
