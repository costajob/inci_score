require 'spec_helper'
require 'inci_score/computer'

describe InciScore::Computer do
  let(:computer) { Stubs::Computer::instance }

  it 'must return ingredients' do
    computer.ingredients.must_equal Stubs::Computer::ingredients
  end

  it 'must map ingredients with components and collect unrecognized' do
    computer.components.must_equal ["aqua", "disodium laureth sulfosuccinate", "cocamidopropyl betaine", "disodium cocoamphodiacetate", "glyceryl laurate", "peg-7 glyceryl cocoate", "sodium lactate", "niacinamide", "glycine", "magnesium aspartate", "alanine", "lysine", "leucine", "allantoin", "peg-150 distearate", "peg-120 methyl glucose dioleate", "phenoxyethanol", "ci 61570"]
  end

  it 'must collect unrecognized components' do
    computer.components
    computer.unrecognized.must_equal %w[parfum]
  end
end
