require 'spec_helper'
require 'inci_score/fuzziness'

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
end
