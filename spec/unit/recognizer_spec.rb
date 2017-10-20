require "helper"

describe InciScore::Recognizer do
  let(:rules) { [] }

  it "must recognize the components based on applied rules" do
    Stubs.components.each do |ingredient, name|
      recognizer = InciScore::Recognizer.new(ingredient, Stubs.catalog)
      recognizer.call.name.must_equal name
    end
  end

  it "must skip recognition for empty ingredient" do
    recognizer = InciScore::Recognizer.new(nil, Stubs.catalog)
    recognizer.call.must_be_nil
  end

  it "must recognize by key only" do
    recognizer = InciScore::Recognizer.new("aqua", Stubs.catalog)
    recognizer.call
    recognizer.applied.must_equal InciScore::Recognizer::DEFAULT_RULES[0,1]
  end

  it "must recognize by key by using synonim" do
    recognizer = InciScore::Recognizer.new("olio di oliva/olea europea", Stubs.catalog)
    recognizer.call
    recognizer.applied.must_equal InciScore::Recognizer::DEFAULT_RULES[0,1]
  end

  it "must recognize by key and levenshtein" do
    recognizer = InciScore::Recognizer.new("agua", Stubs.catalog)
    recognizer.call
    recognizer.applied.must_equal InciScore::Recognizer::DEFAULT_RULES[0,2]
  end

  it "must recognize by key, levenshtein and digits" do
    recognizer = InciScore::Recognizer.new("olea europaea oil", Stubs.catalog)
    recognizer.call
    recognizer.applied.must_equal InciScore::Recognizer::DEFAULT_RULES[0,3]
  end

  it "must recognize by key, levenshtein, digits and tokens" do
    recognizer = InciScore::Recognizer.new("f588 capric triglyceride", Stubs.catalog)
    recognizer.call
    recognizer.applied.must_equal InciScore::Recognizer::DEFAULT_RULES
  end
end
