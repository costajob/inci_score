require 'spec_helper'
require 'inci_score/matcher'

describe InciScore::Matcher do
  let(:ingredient) { 'pegj glyceryi cocoate' }
  let(:matcher) { InciScore::Matcher::new(ingredient) }

  it 'must set initial distance as the ingredient size' do
    matcher.instance_variable_get(:@distance).must_equal ingredient.size
  end
end
