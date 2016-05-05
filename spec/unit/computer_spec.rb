require 'spec_helper'
require 'inci_score/computer'

describe InciScore::Computer do
  let(:computer) { InciScore::Computer::new(catalog: Stubs::Computer::catalog, normalizer: -> { Stubs::Computer::ingredients }) }

  it 'must return ingredients' do
    computer.ingredients.must_equal Stubs::Computer::ingredients
  end

  it 'must map ingredients with components and collect unrecognized' do
    computer.components.must_equal ["aqua", "disodium laureth sulfosuccinate", "cocamidopropyl betaine", "disodium cocoamphodiacetate", "glyceryl laurate", "peg-7 glyceryl cocoate", "sodium lactate", "niacinamide", "glycine", "magnesium aspartate", "alanine", "lysine", "leucine", "allantoin", "peg-150 distearate", "peg-120 methyl glucose dioleate", "phenoxyethanol", "ci 61570", "capryl glycol"]
  end

  it 'must collect unrecognized components' do
    computer.call
    computer.unrecognized.must_equal %w[parfum 50]
  end

  it 'must detect valid state' do
    computer.call
    assert computer.valid?
  end

  it 'must detect invalid state' do
    computer = InciScore::Computer::new(catalog: Stubs::Computer::catalog, normalizer: -> { %w[aqua noent1 noent2] })
    refute computer.valid?
  end

  it 'must compute the score' do
    computer.call.must_be_close_to 81.1, 0.1
  end
end
