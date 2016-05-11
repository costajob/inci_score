require 'spec_helper'
require 'inci_score/computer'

describe InciScore::Computer do
  let(:computer) { InciScore::Computer::new(src: Stubs::Computer::ingredients, catalog: Stubs::Computer::catalog) }

  it 'must collect components' do
    computer.call.components.must_equal({"aqua"=>0, "disodium laureth sulfosuccinate"=>2, "cocamidopropyl betaine"=>1, "disodium cocoamphodiacetate"=>0, "glyceryl laurate"=>0, "peg-7 glyceryl cocoate"=>3, "sodium lactate"=>0, "niacinamide"=>0, "glycine"=>0, "magnesium aspartate"=>0, "alanine"=>0, "lysine"=>0, "leucine"=>0, "allantoin"=>0, "peg-150 distearate"=>3, "peg-120 methyl glucose dioleate"=>3, "phenoxyethanol"=>2, "ci 61570"=>3})
  end

  it 'must collect unrecognized components' do
    computer.call.unrecognized.must_equal %w[parfum 50]
  end

  it 'must detect valid state' do
    assert computer.call.valid
  end

  it 'must detect invalid state' do
    computer = InciScore::Computer::new(src: 'ingredients: aqua, noent1, noent2', catalog: Stubs::Computer::catalog)
    refute computer.call.valid
  end

  it 'must compute the score' do
    computer.call.score.must_equal 81.53770163277234
  end
end
