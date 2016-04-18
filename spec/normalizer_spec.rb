require 'spec_helper'
require 'inci_score/normalizer'

describe InciScore::Normalizer do

  it 'must rase an argument error for missing src' do
    -> { InciScore::Normalizer::new }.must_raise ArgumentError
  end

  it 'must raise an error for missing rule' do
    norm = InciScore::Normalizer::new(src: "Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine", rules: [:noent])
    -> { norm.call }.must_raise InciScore::Normalizer::NoentRuleError
  end

  it 'must apply all rules to tokenize src' do
    Stubs::Normalizer::sources.each do |record|
      norm = InciScore::Normalizer::new(src: record.src)
      norm.call
      norm.src.size.must_equal record.size
    end
  end
end
