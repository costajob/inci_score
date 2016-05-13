require 'spec_helper'
require 'inci_score/recognizer'

describe InciScore::Recognizer do
  let(:catalog) { Stubs::Computer::catalog }

  it 'must recognize component by key first' do
    recognizer = InciScore::Recognizer::new(ingredient: 'ci 61570', catalog: catalog)
    dont_allow(recognizer).by_distance
    dont_allow(recognizer).by_digits
    dont_allow(recognizer).by_tokens
    recognizer.call.must_equal ['ci 61570', 3]
  end

  it 'must fallback to distance rule' do
    recognizer = InciScore::Recognizer::new(ingredient: 'agua', catalog: catalog)
    dont_allow(recognizer).by_digits
    dont_allow(recognizer).by_tokens
    recognizer.call.must_equal ['aqua', 0]
  end

  it 'must fallback to digits rule' do
    recognizer = InciScore::Recognizer::new(ingredient: 'olea europaea oil', catalog: catalog)
    dont_allow(recognizer).by_tokens
    recognizer.call.must_equal ['olea europea', 0]
  end

  it 'must fallback to tokens rule' do
    recognizer = InciScore::Recognizer::new(ingredient: 'f588 capric triglyceride', catalog: catalog)
    recognizer.call.must_equal ['caprylic/capric triglyceride', 0]
  end

  it 'must ignore invlid distances' do
    recognizer = InciScore::Recognizer::new(ingredient: 'de u', catalog: catalog, rules: %w[by_distance])
    refute recognizer.call
  end

  it 'must match first part of component only' do
    recognizer = InciScore::Recognizer::new(ingredient: 'acrylamide', catalog: catalog, rules: %w[by_distance])
    recognizer.call.must_equal ["acrylamide/sodium acrylate copolymer", 3]
  end

  it 'must ignore unmatchable tokens' do
    recognizer = InciScore::Recognizer::new(ingredient: 'selaginella lepidophylla aerial extract', catalog: catalog, rules: %w[by_tokens])
    refute recognizer.call
  end

  it 'must ignore block for recognized component' do
    recognizer = InciScore::Recognizer::new(ingredient: 'aqua', catalog: catalog)
    recognizer.call { |i| fail 'doh!' }.must_equal ['aqua', 0]
  end

  it 'must call the passed block in case of unrcognized component' do
    noent = 'noent'
    recognizer = InciScore::Recognizer::new(ingredient: noent, catalog: catalog)
    unfound = []
    recognizer.call { |ingredient| unfound << ingredient  }
    unfound.must_include noent
  end
end
