# frozen_string_literal: true

require 'helper'

key = InciScore::Recognizer::Rules::Key
levenshtein = InciScore::Recognizer::Rules::Levenshtein
prefix = InciScore::Recognizer::Rules::Prefix
hazard = InciScore::Recognizer::Rules::Hazard
tokens = InciScore::Recognizer::Rules::Tokens

Benchmark.ips do |x|
  x.report('key') do
    key.call('aqua')
  end

  x.report('levenshtein') do
    levenshtein.call('agua')
  end

  x.report('hazard') do
    hazard.call('amino bispropyl dimethicone')
  end

  x.report('prefix') do
    prefix.call('olea europaea oil')
  end

  x.report('tokens') do
    tokens.call('f588 capric triglyceride')
  end
end
