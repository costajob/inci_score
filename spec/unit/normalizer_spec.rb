require 'spec_helper'
require 'inci_score/normalizer'

describe InciScore::Normalizer do
  it 'must raise an argument error for missing src' do
    -> { InciScore::Normalizer::new }.must_raise ArgumentError
  end

  it 'must raise an error for missing rule' do
    norm = InciScore::Normalizer::new(src: Stubs::Normalizer::sources.first, rules: [:noent])
    -> { norm.call }.must_raise InciScore::Normalizer::NoentRuleError
  end

  it 'must apply all rules to fetch ingredients' do
    Stubs::Normalizer::sources.each do |record|
      norm = InciScore::Normalizer::new(src: record.src)
      norm.call.must_equal record.ingredients
    end
  end
end
