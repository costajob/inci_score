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

  it 'must calculate assonance' do
    'bottle'.assonance('battle').must_equal 0
  end

  it 'must return a distance object' do
    'elvis'.distance('elviz').must_be_instance_of InciScore::Fuzziness::Distance
  end

  it 'must return score basing on levenstein and assonance' do
    Stubs::Fuzziness::distances.each do |record|
      record.s.distance(record.t).score.must_be_close_to record.score, record.delta
    end
  end
end
