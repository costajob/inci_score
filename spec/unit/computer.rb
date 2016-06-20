require 'spec_helper'
require 'inci_score/computer'

describe InciScore::Computer do
  let(:computer) { InciScore::Computer.new(src: Stubs::Computer::ingredients, catalog: Stubs::Computer::catalog) }

  it 'must collect components' do
    computer.call.components.must_equal(['aqua', 'disodium laureth sulfosuccinate', 'cocamidopropyl betaine', 'disodium cocoamphodiacetate', 'glyceryl laurate', 'peg-7 glyceryl cocoate', 'sodium lactate', 'parfum', 'niacinamide', 'glycine', 'magnesium aspartate', 'alanine', 'lysine', 'leucine', 'allantoin', 'peg-150 distearate', 'peg-120 methyl glucose dioleate', 'phenoxyethanol', 'ci 61570'])
  end

  it 'must collect unrecognized components' do
    computer.call.unrecognized.must_equal %w[50]
  end

  it 'must detect valid state' do
    assert computer.call.valid
  end

  it 'must detect invalid state' do
    computer = InciScore::Computer.new(src: 'ingredients: aqua, noent1, noent2', catalog: Stubs::Computer::catalog)
    refute computer.call.valid
  end

  it 'must compute the score' do
    computer.call.score.must_equal 81.97262611831569
  end
end
