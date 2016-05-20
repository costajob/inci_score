require 'spec_helper'
require 'inci_score/levenshtein'

describe InciScore::Levenshtein do
  it 'must compute edit distance' do
    Stubs::Levenshtein::strings.each do |record|
      record.s.distance(record.t).must_equal record.distance
      record.s.distance_utf8(record.t).must_equal record.distance
    end
  end

  it 'must treat multiple UTF-8 codepoints as one element' do
    Stubs::Levenshtein::utf8_strings.each do |record|
      record.s.distance_utf8(record.t).must_equal record.distance
    end
  end

  it 'must encode line separators charachters as one element' do
    Stubs::Levenshtein::raw_strings.each do |record|
      record.s.distance_utf8(record.t).must_equal record.distance
    end
  end
end
