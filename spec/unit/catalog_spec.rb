require 'spec_helper'
require 'inci_score/catalog'

describe InciScore::Catalog do
  it 'must return a hash representation' do
    InciScore::Catalog.fetch(Stubs.yaml).fetch("1,3-bis-(2,4-diaminophenoxy)propane").must_equal 4
  end

  it 'must load data once' do
    c1 = InciScore::Catalog.fetch(Stubs.yaml)
    c2 = InciScore::Catalog.fetch(Stubs.yaml)
    c1.__id__.must_equal c2.__id__
  end
end
