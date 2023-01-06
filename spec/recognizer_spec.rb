# frozen_string_literal: true

require 'helper'

describe InciScore::Recognizer do
  let(:rules) { [] }

  it 'must skip recognition for empty ingredient' do
    recognizer = InciScore::Recognizer.new(nil)
    _(recognizer.call).must_be_nil
  end

  it 'must recognize by key' do
    recognizer = InciScore::Recognizer.new('caprylic/capric triglyceride')
    _(recognizer.call.name).must_equal('caprylic/capric triglyceride')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Key
    _(recognizer.precision).must_equal 100
  end

  it 'must recognize component by key synonim' do
    recognizer = InciScore::Recognizer.new('yarrow (achillea millefolium) extract')
    _(recognizer.call.name).must_equal('achillea millefolium')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Key
    _(recognizer.precision).must_equal 100
  end

  it 'must recognize by levenshtein' do
    recognizer = InciScore::Recognizer.new('agua')
    _(recognizer.call.name).must_equal('aqua')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Levenshtein
    _(recognizer.precision).must_be_close_to 86, 0.5
  end

  it 'must recognize by levenshtein' do
    recognizer = InciScore::Recognizer.new('thymus vulgaris oil')
    _(recognizer.call.name).must_equal('thymus vulgaris')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Levenshtein
    _(recognizer.precision).must_be_close_to 86, 0.5
  end

  it 'must recognize by hazard' do
    recognizer = InciScore::Recognizer.new('fimethicone')
    _(recognizer.call.name).must_equal('fimethicone')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Hazard
    _(recognizer.precision).must_be_close_to 77, 0.5
  end

  it 'must recognize by prefix' do
    recognizer = InciScore::Recognizer.new('olea europaea olive oil')
    _(recognizer.call.name).must_equal('olea europaea')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Prefix
    _(recognizer.precision).must_be_close_to 71, 0.5
  end

  it 'must recognize by tokens' do
    recognizer = InciScore::Recognizer.new('f588 capric triglyceride')
    _(recognizer.call.name).must_equal('c10-18 triglycerides')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Tokens
    _(recognizer.precision).must_be_close_to 67, 0.5
  end

  it 'must recognize component by token synonim' do
    recognizer = InciScore::Recognizer.new('mineral oil')
    _(recognizer.call.name).must_equal('paraffinum liquidum (mineral oil)')
    _(recognizer.applied.last).must_equal InciScore::Recognizer::Rules::Tokens
    _(recognizer.precision).must_be_close_to 67, 0.5
  end
end
