# frozen_string_literal: true

require 'helper'
require 'inci_score/recognizer_rules'

describe InciScore::Recognizer::Rules do
  it 'must recognize component by key' do
    rule = InciScore::Recognizer::Rules::Key
    _(rule.call('ci 61570').to_s).must_equal 'ci 61570 (3)'
  end

  it 'must return nil for unfound key' do
    rule = InciScore::Recognizer::Rules::Key
    refute rule.call('watermelon')
  end

  it 'must recognize component by Levenshtein distance' do
    rule = InciScore::Recognizer::Rules::Levenshtein
    _(rule.call('agua').to_s).must_equal 'aqua (0)'
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
    _(rule.call('favothicone').to_s).must_equal 'favothicone (4)'
    _(rule.call('noent peg-4').to_s).must_equal 'noent peg-4 (3)'
    _(rule.call('noent boent glycol').to_s).must_equal 'noent boent glycol (3)'
  end

  it 'must recognize component by prefix' do
    rule = InciScore::Recognizer::Rules::Prefix
    _(rule.call('olea europaea oil').to_s).must_equal 'olea europaea (0)'
  end

  it 'must return nil with no matchings' do
    rule = InciScore::Recognizer::Rules::Prefix
    refute rule.call('melonwater')
  end

  it 'must recognize component by tokens' do
    rule = InciScore::Recognizer::Rules::Tokens
    _(rule.call('f588 capric triglyceride').to_s).must_equal 'c10-18 triglycerides (0)'
    _(rule.call('d-limonene').to_s).must_equal 'limonene (2)'
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
