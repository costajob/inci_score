require 'spec_helper'
require 'inci_score/parser'

describe InciScore::Parser do
  let(:parser) { InciScore::Parser::new(Stubs::Parser::html) }

  it 'must parse HTML document' do
    parser.call.must_equal [{:hazard=>1, :name=>"phosphatidylcholine", :desc=>"emulsionante / condizionante pelle"}, {:hazard=>4, :name=>"1-naphthol", :desc=>"colorante capelli"}, {:hazard=>3, :name=>"1,2,4-benzenetriacetate", :desc=>"colorante capelli"}, {:hazard=>0, :name=>"1,3-bis-(2,4-diaminophenoxy)propane", :desc=>"colorante capelli"}, {:hazard=>2, :name=>"acetylated lanolin", :desc=>"antistatico / emolliente / emulsionante"}]
  end
end
