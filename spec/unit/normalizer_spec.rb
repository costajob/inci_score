require "spec_helper"
require "inci_score/normalizer"

describe InciScore::Normalizer do
  it "must raise an argument error for missing src" do
    -> { InciScore::Normalizer.new }.must_raise ArgumentError
  end

  it "must apply all rules to fetch ingredients" do
    Stubs.sources.each_with_index do |src, i|
      InciScore::Normalizer.new(src: src).call.must_equal Stubs.ingredients[i]
    end
  end

  it "must apply custom rules" do
    custom = [->(src) { src.upcase }, ->(src) { src.split("-").map(&:strip) }]
    normalizer = InciScore::Normalizer.new(src: "aqua/water - parfum - magnesium", rules: custom)
    normalizer.call.must_equal %w[AQUA/WATER PARFUM MAGNESIUM]
  end

  it "can accept a block to augment rules" do
    normalizer = InciScore::Normalizer.new(src: "aqua/water - parfum - magnesium", rules: [->(src) { src.split("-") }])
    stripper = ->(src) { src.map(&:strip) }
    capitalizer = ->(src) { src.map(&:capitalize) }
    normalizer.call do |rules|
      rules << stripper 
      rules << capitalizer
    end
    normalizer.src.must_equal %w[Aqua/water Parfum Magnesium]
  end
end
