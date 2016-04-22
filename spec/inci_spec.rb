require 'spec_helper'
require 'inci_score/inci'

describe InciScore::Inci do
  let(:inci) { Stubs::Inci::instance }

  it 'must return ingredients' do
    inci.ingredients.must_equal Stubs::Inci::ingredients
  end

  it 'must map ingredients with components and collect unrecognized' do
    inci.components.must_equal ["aqua", "disodium laureth sulfosuccinate", "cocamidopropyl betaine", "disodium cocoamphodiacetate", "glyceryl laurate", "peg-7 glyceryl cocoate", "sodium lactate", "acetum", "niacinamide", "glycine", "magnesium aspartate", "alanine", "lysine", "leucine", "allantoin", "peg-150 distearate", "peg-120 methyl glucose dioleate", "phenoxyethanol", "ci 61570"]
  end
end
