# frozen_string_literal: true

require 'helper'
require 'inci_score/recognizer_rules'

describe InciScore::Recognizer::Rules do
  let(:catalog) { Stubs::CATALOG }

  it 'must recognize component by key' do
    rule = InciScore::Recognizer::Rules::Key
    _(rule.call('ci 61570', catalog)).must_equal 'ci 61570'
  end

  it 'must return nil for unfound key' do
    rule = InciScore::Recognizer::Rules::Key
    refute rule.call('water', catalog)
  end

  it 'must recognize component by Levenshtein distance' do
    rule = InciScore::Recognizer::Rules::Levenshtein
    _(rule.call('agua', catalog)).must_equal 'aqua'
  end

  it 'returns nil if too distant' do
    rule = InciScore::Recognizer::Rules::Levenshtein
    refute rule.call('water', catalog)
  end

  it 'returns nil for empty ingredient' do
    rule = InciScore::Recognizer::Rules::Levenshtein
    refute rule.call('', catalog)
  end

  it 'must recognize component by meaningful digits' do
    rule = InciScore::Recognizer::Rules::Digits
    _(rule.call('olea europaea oil', catalog)).must_equal 'olea europea'
  end

  it 'must recognize generic hazard' do
    rule = InciScore::Recognizer::Rules::Hazard
    _(rule.call('favothicone', catalog)).must_equal 'generic-hazard'
    _(rule.call('noent peg-4', catalog)).must_equal 'generic-hazard'
    _(rule.call('noent boent glicol', catalog)).must_equal 'generic-hazard'
  end

  it 'must return nil with no matchings' do
    rule = InciScore::Recognizer::Rules::Digits
    refute rule.call('water', catalog)
  end

  it 'must recognize component by tokens' do
    rule = InciScore::Recognizer::Rules::Tokens
    _(rule.call('f588 capric triglyceride', catalog)).must_equal 'caprylic/capric triglyceride'
  end

  it 'must return nil with no matchings' do
    rule = InciScore::Recognizer::Rules::Tokens
    refute rule.call('agua', catalog)
  end
end
