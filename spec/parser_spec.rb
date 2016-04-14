require 'spec_helper'
require 'inci_score/parser'

describe InciScore::Parser do
  let(:parser) { InciScore::Parser::new(doc: Stubs::Parser::html) }

  it 'must memoize computation' do
    assert parser.call.equal? parser.call
  end

  it 'must collect component data properly' do
    parser.call.must_equal ['phosphatidylcholine', 
                            '1-naphthol', 
                            '1,2,4-benzenetriacetate', 
                            '1,3-bis-(2,4-diaminophenoxy)propane', 
                            'acetylated lanolin'].map! { |name| InciScore::Component::new(name: name) }
  end
end
