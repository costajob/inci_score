require 'spec_helper'
require 'inci_score/fuzzy_refinements'
using InciScore::FuzzyRefinements

describe InciScore::FuzzyRefinements do
  describe '#distance' do
    it 'must compute edit distance' do
      Stubs::single.each do |dist|
        dist.s.distance(dist.t).must_equal dist.d
      end
    end

    it 'must return string length if blank is compared' do
      s = 'loveme'
      s.distance('').must_equal s.length
      ''.distance(s).must_equal s.length
    end

    it 'must treat  multiple UTF-8 codepoints as one element' do
      Stubs::multiple.each do |dist|
        dist.s.distance(dist.t).must_equal dist.d
      end
    end

    it 'must encode special charachters as one element' do
      Stubs::special.each do |dist|
        dist.s.distance(dist.t).must_equal dist.d
      end
    end
  end
end
