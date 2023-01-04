# frozen_string_literal: true

require 'helper'

key = InciScore::Recognizer::Rules::Key
levenshtein = InciScore::Recognizer::Rules::Levenshtein
digits = InciScore::Recognizer::Rules::Digits
hazard = InciScore::Recognizer::Rules::Hazard
tokens = InciScore::Recognizer::Rules::Tokens
catalog = Stubs::CATALOG

Benchmark.ips do |x|
  x.report('key') do
    key.call('aqua', catalog)
  end

  x.report('levenshtein') do
    levenshtein.call('agua', catalog)
  end

  x.report('hazard') do
    hazard.call('amino bispropyl dimethicone', catalog)
  end

  x.report('digits') do
    digits.call('olea europaea oil', catalog)
  end

  x.report('tokens') do
    tokens.call('f588 capric triglyceride', catalog)
  end
end
