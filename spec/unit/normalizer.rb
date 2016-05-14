require 'spec_helper'
require 'inci_score/normalizer'

describe InciScore::Normalizer do
  it 'must raise an argument error for missing src' do
    -> { InciScore::Normalizer::new }.must_raise ArgumentError
  end

  it 'must apply all rules to fetch ingredients' do
    Stubs::Normalizer::sources.each do |record|
      norm = InciScore::Normalizer::new(src: record.src)
      norm.call.must_equal record.ingredients
    end
  end
end
