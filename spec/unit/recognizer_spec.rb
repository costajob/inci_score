require 'spec_helper'
require 'inci_score/recognizer'

describe InciScore::Recognizer do
  let(:catalog) { Stubs::Computer::catalog }

  it 'must compute component' do
    Stubs::Recognizer::components.each do |record|
      InciScore::Recognizer::new(ingredient: record.ingredient, catalog: catalog).call.must_equal record.component
    end
  end
end
