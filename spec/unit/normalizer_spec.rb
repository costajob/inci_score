require 'spec_helper'
require 'inci_score/normalizer'

describe InciScore::Normalizer do
  let(:ingredients) { "Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Giyceryi Laurate, PEGJ\nGlyceryi  Cocoate, Sodium Lactate_" }

  it 'must raise an argument error for missing src' do
    -> { InciScore::Normalizer::new }.must_raise ArgumentError
  end

  it 'must raise an error for missing rule' do
    norm = InciScore::Normalizer::new(src: ingredients, rules: [:noent])
    -> { norm.call }.must_raise InciScore::Normalizer::NoentRuleError
  end

  it 'must apply all rules to tokenize src' do
    Stubs::Normalizer::sources.each do |record|
      norm = InciScore::Normalizer::new(src: record.src)
      norm.call.size.must_equal record.size
    end
  end

  it 'must normalize ingredients per applied rules' do
    norm = InciScore::Normalizer::new(src: ingredients) 
    norm.call.must_equal ["aqua", "disodium laureth sulfosuccinate", "cocamidopropiyl betaine", "giyceryi laurate", "pegj glyceryi cocoate", "sodium lactate"]
  end
end
