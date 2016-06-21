require 'spec_helper'
require 'inci_score/normalizer'

describe InciScore::Normalizer do
  it 'must raise an argument error for missing src' do
    -> { InciScore::Normalizer.new }.must_raise ArgumentError
  end

  it 'must apply all rules to fetch ingredients' do
    Stubs.sources.each_with_index do |src, i|
      InciScore::Normalizer.new(src: src).call.must_equal Stubs.ingredients[i]
    end
  end
end
