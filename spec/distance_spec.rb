require 'spec_helper'
require 'inci_score/distance'

describe InciScore::Distance do
  it 'must return score basing on levenstein and assonance' do
    Stubs::Distance::records.each do |record|
      InciScore::Distance::new(record.s, record.t).score.must_equal record.score2
      InciScore::Distance::new(record.s, record.t, true).score.must_equal record.score1
    end
  end
end
