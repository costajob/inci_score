# frozen_string_literal: true

require 'helper'

describe InciScore::Ingredient do
  it 'must be represented as a string' do
    ingredient = InciScore::Ingredient.new('acrylamidopropyltrimonium chloride/acrylates copolymer')
    _(ingredient.to_s).must_equal 'acrylamidopropyltrimonium chloride/acrylates copolymer'
  end

  it 'must be represented as a string with parenthesis' do
    ingredient = InciScore::Ingredient.new('1,3-bis-(2,4-diaminophenoxy)propane')
    _(ingredient.to_s).must_equal '1,3-bis-propane/2,4-diaminophenoxy'
  end

  it 'must fetch values with plain name' do
    ingredient = InciScore::Ingredient.new('aqua')
    _(ingredient.values).must_equal ['aqua']
  end

  it 'must fetch values with synonims' do
    ingredient = InciScore::Ingredient.new('peg-3/ppg-2 glyceryl/sorbitol hydroxystearate/isostearate')
    _(ingredient.values).must_equal ['peg-3', 'ppg-2 glyceryl', 'sorbitol hydroxystearate/isostearate']
  end

  it 'must fetch values with initial parenthesis' do
    ingredient  = InciScore::Ingredient.new('(kelp) macrocystis pyrifera')
    _(ingredient.values).must_equal ['macrocystis pyrifera', 'kelp']
  end

  it 'must fetch values with middle parenthesis' do
    ingredient = InciScore::Ingredient.new('yarrow (achillea millefolium) extract')
    _(ingredient.values).must_equal ['yarrow extract', 'achillea millefolium']
  end

  it 'must fetch values with final parenthesis' do
    ingredient  = InciScore::Ingredient.new('camelia sinensis (leave on)')
    _(ingredient.values).must_equal ['camelia sinensis', 'leave on']
  end
end
