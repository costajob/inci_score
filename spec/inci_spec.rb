require 'spec_helper'
require 'inci_score/inci'

describe InciScore::Inci do
  let(:ingredients) { ["aqua", "disodium laureth sulfosuccinate", "cocamidopropiyl betaine", "disodium cocoamphodiacetate", "giyceryi laurate", "pegj glyceryi cocoate", "sodium lactate", "parfum", "niacinamide", "glycine", "magnesium aspanate", "aianine", "lysine", "leucine", "allantoin", "peg150 e  distearate", "peg120 methyl glucose dioleate", "phenoxyethanoi", "ci 61570", "50"] }
  let(:inci) { InciScore::Inci::new(catalog: Stubs::Inci::catalog, normalizer: -> { ingredients } ) }

  it 'must return ingredients' do
    inci.ingredients.must_equal ingredients
  end
end
