require 'spec_helper'
require 'inci_score/levenshtein'

describe InciScore::Levenshtein do
  it 'must compute edit distance for UTF8 characters' do
    Stubs.distances.each do |args|
      t, s, d = *args
      s.distance_utf8(t).must_equal d
    end
  end

  it 'must compute edit distance' do
    Stubs.distances.first(8).each do |args|
      t, s, d = *args
      s.distance(t).must_equal d
    end
  end
end
