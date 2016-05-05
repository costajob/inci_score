require 'spec_helper'
require 'inci_score/recognizer'

describe InciScore::Recognizer do
  let(:catalog) { Stubs::Computer::catalog }
  let(:noent) { 'aquascout' }

  it 'must compute component' do
    Stubs::Recognizer::components.each do |record|
      InciScore::Recognizer::new(ingredient: record.ingredient, catalog: catalog).call.must_equal record.component
    end
  end

  it 'must ignore block for recognized component' do
    recognizer = InciScore::Recognizer::new(ingredient: 'aqua 2000', catalog: catalog)
    recognizer.call { |i| fail 'doh!' }.must_equal 'aqua'
  end

  it 'must call the passed block in case of unrcognized component' do
    recognizer = InciScore::Recognizer::new(ingredient: noent, catalog: catalog)
    unfound = []
    recognizer.call { |ingredient| unfound << ingredient  }
    unfound.must_include noent
  end
end
