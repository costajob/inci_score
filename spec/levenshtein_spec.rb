require 'spec_helper'
require 'inci_score/levenshtein'

describe InciScore::Levenshtein do
  it 'must compute edit distance' do
    Stubs::Levenshtein::single.each do |record|
      InciScore::Levenshtein::new(record.s, record.t).call.must_equal record.distance
    end
  end

  it 'must be case sensitive' do
    InciScore::Levenshtein::new('elvis', 'Elvis').call.must_equal 1
  end

  it 'must return string length if blank is compared' do
    s = 'loveme'
    InciScore::Levenshtein::new(s, '').call.must_equal s.length
    InciScore::Levenshtein::new('', s).call.must_equal s.length
  end

  it 'must treat multiple UTF-8 codepoints as one element' do
    Stubs::Levenshtein::multiple.each do |record|
      InciScore::Levenshtein::new(record.s, record.t).call.must_equal record.distance
    end
  end

  it 'must encode special charachters as one element' do
    Stubs::Levenshtein::special.each do |record|
      InciScore::Levenshtein::new(record.s, record.t).call.must_equal record.distance
    end
  end
end
