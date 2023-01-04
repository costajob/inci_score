# frozen_string_literal: true

require 'helper'

describe InciScore::Recognizer do
  let(:rules) { [] }
  let(:catalog) { Stubs::CATALOG }

  it 'must recognize the components based on applied rules' do
    Stubs::COMPONENTS.each do |ingredient, name|
      recognizer = InciScore::Recognizer.new(ingredient, catalog)
      _(recognizer.call.name).must_equal name
    end
  end

  it 'must skip recognition for empty ingredient' do
    recognizer = InciScore::Recognizer.new(nil, catalog)
    _(recognizer.call).must_be_nil
  end

  it 'must recognize by key only' do
    recognizer = InciScore::Recognizer.new('aqua', catalog)
    recognizer.call
    _(recognizer.applied).must_equal InciScore::Recognizer::DEFAULT_RULES[0,1]
  end

  it 'must recognize by key by using synonim' do
    recognizer = InciScore::Recognizer.new('olio di oliva/olea europea', catalog)
    recognizer.call
    _(recognizer.applied).must_equal InciScore::Recognizer::DEFAULT_RULES[0,1]
  end

  it 'must recognize by key and levenshtein' do
    recognizer = InciScore::Recognizer.new('agua', catalog)
    recognizer.call
    _(recognizer.applied).must_equal InciScore::Recognizer::DEFAULT_RULES[0,2]
  end

  it 'must recognize by key, levenshtein and digits' do
    recognizer = InciScore::Recognizer.new('olea europaea oil', catalog)
    recognizer.call
    _(recognizer.applied).must_equal InciScore::Recognizer::DEFAULT_RULES[0,3]
  end

  it 'must recognize by key, levenshtein, digits and hazard' do
    recognizer = InciScore::Recognizer.new('amino bispropyl dimethicone', catalog)
    recognizer.call
    _(recognizer.applied).must_equal InciScore::Recognizer::DEFAULT_RULES[0,4]
  end

  it 'must recognize by key, levenshtein, digits, hazard and tokens' do
    recognizer = InciScore::Recognizer.new('f588 capric triglyceride', catalog)
    recognizer.call
    _(recognizer.applied).must_equal InciScore::Recognizer::DEFAULT_RULES[0,5]
  end
end
