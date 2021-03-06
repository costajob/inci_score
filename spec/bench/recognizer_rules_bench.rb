require "helper"

key = InciScore::Recognizer::Rules::Key
levenshtein = InciScore::Recognizer::Rules::Levenshtein
digits = InciScore::Recognizer::Rules::Digits
tokens = InciScore::Recognizer::Rules::Tokens

Benchmark.ips do |x|
  x.report("key") do
    key.call("aqua", Stubs.catalog)
  end

  x.report("levenshtein") do
    levenshtein.call("agua", Stubs.catalog)
  end

  x.report("digits") do
    digits.call("olea europaea oil", Stubs.catalog)
  end

  x.report("tokens") do
    tokens.call("f588 capric triglyceride", Stubs.catalog)
  end
end
