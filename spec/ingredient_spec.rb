# frozen_string_literal: true

require 'helper'

describe InciScore::Ingredient do
  it 'must fetch values with plain name' do
    ingredient = InciScore::Ingredient.new('aqua')
    _(ingredient.values).must_equal ['aqua']
  end

  it 'must fetch values with synonims' do
    ingredient = InciScore::Ingredient.new('peg-3/ppg-2 glyceryl/sorbitol hydroxystearate/isostearate')
    _(ingredient.values).must_equal ['peg-3/ppg-2 glyceryl/sorbitol hydroxystearate/isostearate', 'peg-3', 'ppg-2 glyceryl', 'sorbitol hydroxystearate/isostearate']
  end

  it 'must fetch values with initial parenthesis' do
    ingredient  = InciScore::Ingredient.new('(kelp) macrocystis pyrifera')
    _(ingredient.values).must_equal ['(kelp) macrocystis pyrifera', 'macrocystis pyrifera', 'kelp']
  end

  it 'must fetch values with middle parenthesis' do
    ingredient = InciScore::Ingredient.new('prunus amygdalus dulcis (sweet almond) oil')
    _(ingredient.values).must_equal ['prunus amygdalus dulcis (sweet almond) oil', 'prunus amygdalus dulcis oil', 'sweet almond']
  end

  it 'must fetch values with final parenthesis' do
    ingredient  = InciScore::Ingredient.new('camelia sinensis (leave on)')
    _(ingredient.values).must_equal ['camelia sinensis (leave on)', 'camelia sinensis', 'leave on']
  end
end
