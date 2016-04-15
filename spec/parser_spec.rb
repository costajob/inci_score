require 'spec_helper'
require 'inci_score/parser'

describe InciScore::Parser do
  let(:parser) { InciScore::Parser::new(Stubs::Parser::html) }

  it 'must replace duplicate entries' do
    parser.call.size.must_equal 5
  end

  it 'must collect component data properly' do
    parser.call.must_equal({"phosphatidylcholine"=>1, "1-naphthol"=>4, "1,2,4-benzenetriacetate"=>3, "1,3-bis-(2,4-diaminophenoxy)propane"=>0, "acetylated lanolin"=>2})
  end
end
