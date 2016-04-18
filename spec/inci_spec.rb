require 'spec_helper'
require 'inci_score/inci'

describe InciScore::Inci do
  it 'must rase an argument error for missing src' do
    -> { InciScore::Inci::new }.must_raise ArgumentError
  end
end
