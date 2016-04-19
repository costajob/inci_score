require 'bench_helper'
require 'inci_score/inci'

ingredients = ["aqua", "disodium laureth sulfosuccinate", "cocamidopropiyl betaine", "disodium cocoamphodiacetate", "giyceryi laurate", "pegj glyceryi cocoate", "sodium lactate", "parfum", "niacinamide", "glycine", "magnesium aspanate", "aianine", "lysine", "leucine", "allantoin", "peg150 e  distearate", "peg120 methyl glucose dioleate", "phenoxyethanoi", "ci 61570", "50"]
inci = InciScore::Inci::new(catalog: Stubs::Inci::catalog, normalizer: -> { ingredients })

Benchmark::ips do |x| 
  x.report('scores') do
    inci.scores
  end
end
