require "helper"

describe InciScore::Ingredient do
  it "must be represented as a string" do
    ingredient = InciScore::Ingredient.new("acrylamidopropyltrimonium chloride/acrylates copolymer")
    ingredient.to_s.must_equal "acrylamidopropyltrimonium chloride/acrylates copolymer"
  end

  it "must be represented as a string withoud details" do
    ingredient = InciScore::Ingredient.new("1,3-bis-(2,4-diaminophenoxy)propane")
    ingredient.to_s.must_equal "1,3-bis-propane"
  end

  it "must fetch values with plain name" do
    ingredient = InciScore::Ingredient.new("aqua")
    ingredient.values.must_equal ["aqua"]
  end

  it "must fetch values with syninims" do
    ingredient = InciScore::Ingredient.new("peg-3/ppg-2 glyceryl/sorbitol hydroxystearate/isostearate")
    ingredient.values.must_equal ["peg-3", "ppg-2 glyceryl", "sorbitol hydroxystearate/isostearate"]
  end

  it "must fetch values with details" do
    ingredient  = InciScore::Ingredient.new("camelia sinensis (leave on)")
    ingredient.values.must_equal ["camelia sinensis"]
  end
end
