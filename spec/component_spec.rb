require 'spec_helper'
require 'inci_score/component'

describe InciScore::Component do
  it 'must rais an argument error for missing attributes' do
    -> { InciScore::Component::new(hazard: 1) }.must_raise ArgumentError
  end

  it 'must define equality by name' do
    c1 = InciScore::Component::new(hazard: 1, name: 'phosphatidylcholine')
    c2 = InciScore::Component::new(hazard: 2, name: 'phosphatidylcholine', desc: 'emulsionante / condizionante pelle')
    c1.must_equal c2
  end
end
