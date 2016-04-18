require 'spec_helper'
require 'inci_score/inci'

describe InciScore::Inci do
  let(:src) { "Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Disodium Cocoamphodiacetate, Giyceryi Laurate, PEGJ\nGlyceryi Cocoate, Sodium Lactate, Parfum,\n\nNiacinamide, Glycine, Magnesium Aspanate,\n\nAianine, Lysine, Leucine,A||antoin, PEG-150 E‘—\n\nDistearate, PEG-120 Methyl Glucose Dioleate, ——\n\nPhenoxyethanoi, CI 61570. 50\n\n \n\n" }
  let(:catalog) { {"phosphatidylcholine"=>1, "1-naphthol"=>4, "1,2,4-benzenetriacetate"=>4, "1,3-bis-(2,4-diaminophenoxy)propane"=>4, "1,5-naphthalenediol"=>4, "2-aminobutanol"=>3, "2-bromo-2-nitropropane-1,3-diol"=>4, "2-chloro-6-ethylamino-4-nitrophenol"=>4, "2-heptylcyclopentanone"=>4, "2-hydroxyethyl picramic acid"=>4} }
  let(:inci) { InciScore::Inci::new(src: src, catalog: catalog) }

  it 'must rase an argument error for missing src' do
    -> { InciScore::Inci::new }.must_raise ArgumentError
  end
end
