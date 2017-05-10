require "spec_helper"
require "inci_score/recognizer"

describe InciScore::Recognizer do
  let(:rules) { [] }

  it "must recognize the components based on applied rules" do
    Stubs.components.each do |ingredient, output|
      recognizer = InciScore::Recognizer.new(ingredient, Stubs.catalog)
      recognizer.call.must_equal output
    end
  end

  it "must recognize by key only" do
    recognizer = InciScore::Recognizer.new("aqua", Stubs.catalog)
    recognizer.call do |r|
      rules << r
    end
    rules.must_equal InciScore::Recognizer::DEFAULT_RULES[0,1]
  end

  it "must recognize by key and levenshtein" do
    recognizer = InciScore::Recognizer.new("agua", Stubs.catalog)
    recognizer.call do |r|
      rules << r
    end
    rules.must_equal InciScore::Recognizer::DEFAULT_RULES[0,2]
  end

  it "must recognize by key, levenshtein and digits" do
    recognizer = InciScore::Recognizer.new("olea europaea oil", Stubs.catalog)
    recognizer.call do |r|
      rules << r
    end
    rules.must_equal InciScore::Recognizer::DEFAULT_RULES[0,3]
  end

  it "must recognize by key, levenshtein, digits and tokens" do
    recognizer = InciScore::Recognizer.new("f588 capric triglyceride", Stubs.catalog)
    recognizer.call do |r|
      rules << r
    end
    rules.must_equal InciScore::Recognizer::DEFAULT_RULES
  end

  it "must recognize by key and levenshtein precisely" do
    recognizer = InciScore::Recognizer.new("i 47005", Stubs.catalog)
    recognizer.call(true) do |r|
      rules << r
    end
    rules.must_equal InciScore::Recognizer::DEFAULT_RULES[0,2]
  end
end
