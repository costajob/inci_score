require 'spec_helper'
require 'inci_score/recognizer'

describe InciScore::Recognizer do
  it 'must recognize the components based on applied rules' do
    Stubs.components.each do |ingredient, output|
      recognizer = InciScore::Recognizer.new(ingredient, Stubs.catalog)
      recognizer.call.must_equal output
    end
  end
end
