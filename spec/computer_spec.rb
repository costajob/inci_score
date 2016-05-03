require 'spec_helper'
require 'inci_score/computer'

describe InciScore::Computer do
  let(:computer) { Stubs::Computer::instance }

  it 'must return ingredients' do
    computer.call
    computer.ingredients.must_equal Stubs::Computer::ingredients
  end

  it 'must map ingredients with components and collect unrecognized' do
    computer.call
    computer.components.must_equal ["aqua", "disodium laureth sulfosuccinate", "cocamidopropyl betaine", "disodium cocoamphodiacetate", "glyceryl laurate", "peg-7 glyceryl cocoate", "sodium lactate", "niacinamide", "glycine", "magnesium aspartate", "alanine", "lysine", "leucine", "allantoin", "peg-150 distearate", "peg-120 methyl glucose dioleate", "phenoxyethanol", "ci 61570"]
  end

  it 'must collect unrecognized components' do
    computer.call
    computer.unrecognized.must_equal %w[parfum 50]
  end

  it 'must raise an error for too many unrecognized ingredients' do
    computer = InciScore::Computer::new(catalog: Stubs::Computer::catalog, normalizer: -> { %w[parfum glycerin dimthicone] } )
    -> { computer.call }.must_raise InciScore::Computer::UnrecognizedIngredientsError
  end
end
