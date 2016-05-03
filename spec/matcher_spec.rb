require 'spec_helper'
require 'inci_score/matcher'

describe InciScore::Matcher do
  let(:component) { 'peg-7 glyceryl cocoate' }
  let(:unrecognized) { 'peg-7 cocamide' }
  let(:ingredient) { 'pegj glyceryi cocoate' }
  let(:matcher) { InciScore::Matcher::new(ingredient) }

  it 'must set initial distance to the ingredient size' do
    matcher.distance.must_equal ingredient.size
  end

  it 'must update component if distance is smaller than current one' do
    matcher.update!(component)
    matcher.distance.must_equal 3
    matcher.component.must_equal component
  end

  it 'wont update component if distance is greater or equal than current one' do
    matcher.update!(component)
    matcher.update!(unrecognized)
    matcher.component.must_equal component
  end

  it 'must return matching component if distance is smaller or equal than tollerance' do
    matcher.update!(component)
    matcher.call.must_equal component
  end

  it 'must return nil and store unrecognized if distance is greater than tollerance' do
    matcher.update!(unrecognized)
    refute matcher.call
    matcher.unrecognized.must_include ingredient 
  end
end
