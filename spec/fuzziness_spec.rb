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

  it 'must compute distance' do
    'battle'.distance('bottley').must_equal 8
  end

  it 'must compute distance with assonance' do
    'battle'.distance('bottley', true).must_equal 8.5
  end
end
