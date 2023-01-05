# frozen_string_literal: true

require 'helper'

describe InciScore::Recognizer do
  let(:rules) { [] }

  it 'must recognize the components based on applied rules' do
    Stubs::COMPONENTS.each do |ingredient, name|
      recognizer = InciScore::Recognizer.new(ingredient)
      _(recognizer.call.name).must_equal name
    end
  end

  it 'must skip recognition for empty ingredient' do
    recognizer = InciScore::Recognizer.new(nil)
    _(recognizer.call).must_be_nil
  end

  it 'must recognize by key' do
    recognizer = InciScore::Recognizer.new('aqua')
    _(recognizer.call).must_be_instance_of InciScore::Recognizer::Component
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Key
  end

  it 'must recognize component by key synonim' do
    recognizer = InciScore::Recognizer.new('yarrow (achillea millefolium) extract')
    _(recognizer.call).must_be_instance_of InciScore::Recognizer::Component
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Key
  end

  it 'must recognize by levenshtein' do
    recognizer = InciScore::Recognizer.new('agua')
    _(recognizer.call).must_be_instance_of InciScore::Recognizer::Component
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Levenshtein
  end

  it 'must recognize by hazard' do
    recognizer = InciScore::Recognizer.new('fimethicone')
    _(recognizer.call).must_be_instance_of InciScore::Recognizer::Component
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Hazard
  end

  it 'must recognize by prefix' do
    recognizer = InciScore::Recognizer.new('olea europaea oil')
    _(recognizer.call).must_be_instance_of InciScore::Recognizer::Component
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Prefix
  end

  it 'must recognize by tokens' do
    recognizer = InciScore::Recognizer.new('f588 capric triglyceride')
    _(recognizer.call).must_be_instance_of InciScore::Recognizer::Component
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Tokens
  end

  it 'must recognize' do
    recognizer = InciScore::Recognizer.new('yarrow (achillea millefolium) extract')
    recognizer.call
  end
end
