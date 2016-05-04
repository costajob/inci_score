require 'spec_helper'
require 'inci_score/matcher'

describe InciScore::Matcher do
  let(:component) { 'peg-7 glyceryl cocoate' }
  let(:unrecognized) { 'peg-7 cocamide' }
  let(:short) { 'xx' }
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

  it 'must ignore block for recognized component' do
    matcher.update!(component)
    matcher.call { |i| fail 'doh!' }.must_equal component
  end

  it 'must return nil if distance is greater than tollerance' do
    matcher.update!(unrecognized)
    refute matcher.call
  end

  it 'must call the passed block in case of unrcognized component' do
    matcher = InciScore::Matcher::new(short)
    matcher.update!(component)
    unfound = []
    matcher.call { |ingredient| unfound << ingredient  }
    unfound.must_include short
  end
end
