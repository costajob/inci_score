require 'spec_helper'
require 'inci_score/recognizer_rules'

describe InciScore::Recognizer::Rules do
  let(:catalog) { Stubs.catalog }

  it 'must recognize component by key' do
    rule = InciScore::Recognizer::Rules::Key.new('ci 61570', catalog)
    rule.call.must_equal 'ci 61570'
  end

  it 'must return nil for unfound key' do
    rule = InciScore::Recognizer::Rules::Key.new('water', catalog)
    refute rule.call
  end

  it 'must recognize component by Levenshtein distance' do
    rule = InciScore::Recognizer::Rules::Levenshtein.new('hagua', catalog)
    rule.call.must_equal 'aqua'
  end

  it 'must match on first part of ingredient only' do
    rule = InciScore::Recognizer::Rules::Levenshtein.new('acrylamide', catalog)
    rule.call.must_equal 'acrylamide/sodium acrylate copolymer'
  end

  it 'returns nil if too distant' do
    rule = InciScore::Recognizer::Rules::Levenshtein.new('water', catalog)
    refute rule.call
  end

  it 'must recognize component by meaningful digits' do
    rule = InciScore::Recognizer::Rules::Digits.new('olea europaea oil', catalog)
    rule.call.must_equal 'olea europea'
  end

  it 'must return nil with no matchings' do
    rule = InciScore::Recognizer::Rules::Digits.new('water', catalog)
    refute rule.call
  end

  it 'must recognize component by tokens' do
    rule = InciScore::Recognizer::Rules::Tokens.new('f588 capric triglyceride', catalog)
    rule.call.must_equal 'caprylic/capric triglyceride'
  end

  it 'must return nil with no matchings' do
    rule = InciScore::Recognizer::Rules::Tokens.new('agua', catalog)
    refute rule.call
  end
end
