require 'spec_helper'
require 'inci_score/parser'

describe InciScore::Parser do
  it 'must parse HTML document' do
    parser = InciScore::Parser::new(doc: Stubs::Parser::html)
    components = parser.call
    assert components.all? { |c| c.instance_of?(InciScore::Component)}
  end
end
