# frozen_string_literal: true

require 'helper'

describe InciScore::Catalog do
  it 'must return a hash representation' do
    _(InciScore::Catalog.fetch(Stubs.yaml).fetch('1,3-bis-(2,4-diaminophenoxy)propane')).must_equal 4
  end
end
