require 'spec_helper'
require 'inci_score/recognizer'

describe InciScore::Recognizer do
  let(:catalog) { Stubs::Computer::catalog }

  it 'must recognize component by key first' do
    recognizer = InciScore::Recognizer::new(ingredient: 'ci 61570', catalog: catalog)
    dont_allow(recognizer).by_distance
    dont_allow(recognizer).by_digits
    dont_allow(recognizer).by_tokens
    recognizer.call.must_equal 'ci 61570'
  end

  it 'must fallback to distance rule' do
    recognizer = InciScore::Recognizer::new(ingredient: 'agua', catalog: catalog)
    dont_allow(recognizer).by_digits
    dont_allow(recognizer).by_tokens
    recognizer.call.must_equal 'aqua'
  end

  it 'must fallback to digits rule' do
    recognizer = InciScore::Recognizer::new(ingredient: 'olea europaea oil i 0 6100 stearate', catalog: catalog)
    dont_allow(recognizer).by_tokens
    recognizer.call.must_equal 'olea europea'
  end

  it 'must fallback to tokens rule' do
    recognizer = InciScore::Recognizer::new(ingredient: 'f588 capric triglyceride', catalog: catalog)
    recognizer.call.must_equal 'caprylic/capric triglyceride'
  end

  it 'must ignore block for recognized component' do
    recognizer = InciScore::Recognizer::new(ingredient: 'aqua 2000', catalog: catalog)
    recognizer.call { |i| fail 'doh!' }.must_equal 'aqua'
  end

  it 'must call the passed block in case of unrcognized component' do
    noent = 'aquascout'
    recognizer = InciScore::Recognizer::new(ingredient: noent, catalog: catalog)
    unfound = []
    recognizer.call { |ingredient| unfound << ingredient  }
    unfound.must_include noent
  end
end
