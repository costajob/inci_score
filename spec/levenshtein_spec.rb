# frozen_string_literal: true

require 'helper'

describe InciScore::Levenshtein do
  it 'must compute edit distance for UTF8 characters' do
    Stubs::DISTANCES.each do |args|
      t, s, d = *args
      lev = InciScore::Levenshtein.new(s, t)
      _(lev.call).must_equal d
    end
  end

  it 'must compute edit distance' do
    Stubs::DISTANCES.first(8).each do |args|
      t, s, d = *args
      lev = InciScore::LevenshteinC.new.call(s.downcase, s.size, t.downcase, t.size)
      _(lev).must_equal d
    end
  end
end
