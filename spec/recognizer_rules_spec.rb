# frozen_string_literal: true

require 'helper'
require 'inci_score/recognizer_rules'

describe InciScore::Recognizer::Rules do
  it 'must recognize component by key' do
    rule = InciScore::Recognizer::Rules::Key
    _(rule.call('ci 61570').name).must_equal 'ci 61570'
  end

  it 'must return nil for unfound key' do
    rule = InciScore::Recognizer::Rules::Key
    refute rule.call('watermelon')
  end

  it 'must recognize component by Levenshtein distance' do
    rule = InciScore::Recognizer::Rules::Levenshtein
    _(rule.call('agua').name).must_equal 'aqua'
  end

  it 'returns nil if too distant' do
    rule = InciScore::Recognizer::Rules::Levenshtein
    refute rule.call('watermelon')
  end

  it 'returns nil for empty ingredient' do
    rule = InciScore::Recognizer::Rules::Levenshtein
    refute rule.call('')
  end

  it 'must recognize generic hazard' do
    rule = InciScore::Recognizer::Rules::Hazard
    _(rule.call('favothicone').name).must_equal 'favothicone'
    _(rule.call('noent peg-4').name).must_equal 'noent peg-4'
    _(rule.call('noent boent glycol').name).must_equal 'noent boent glycol'
  end

  it 'must recognize component by prefix' do
    rule = InciScore::Recognizer::Rules::Prefix
    _(rule.call('olea europaea oil').name).must_equal 'olea europaea'
  end

  it 'must return nil with no matchings' do
    rule = InciScore::Recognizer::Rules::Prefix
    refute rule.call('melonwater')
  end

  it 'must recognize component by tokens' do
    rule = InciScore::Recognizer::Rules::Tokens
    _(rule.call('f588 capric triglyceride').name).must_equal 'c10-18 triglycerides'
    _(rule.call('d-limonene').name).must_equal 'limonene'
  end

  it 'must return nil with short matchings' do
    rule = InciScore::Recognizer::Rules::Tokens
    refute rule.call('imo')
  end

  it 'must return nil with no matchings' do
    rule = InciScore::Recognizer::Rules::Tokens
    refute rule.call('watermelon')
  end
end
