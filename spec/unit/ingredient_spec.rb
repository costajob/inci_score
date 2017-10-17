require "spec_helper"
require "inci_score/ingredient"

describe InciScore::Ingredient do
  describe "plain name" do
    let(:ingredient) { InciScore::Ingredient.new("aqua") }

    it "must fetch name" do
      ingredient.name.must_equal "aqua"
    end

    it "must fetch synonims" do
      ingredient.synonims.must_be_empty
    end

    it "must fetch details" do
      ingredient.details.must_be_nil
    end
  end

  describe "with synonims" do
    let(:ingredient) { InciScore::Ingredient.new("peg-3/ppg-2 glyceryl/sorbitol hydroxystearate/isostearate") }

    it "must fetch name" do
      ingredient.name.must_equal "peg-3"
    end

    it "must fetch synonims" do
      ingredient.synonims.must_equal ["ppg-2 glyceryl", "sorbitol hydroxystearate/isostearate"]
    end

    it "must fetch details" do
      ingredient.details.must_be_nil
    end
  end

  describe "with details" do
    let(:ingredient) { InciScore::Ingredient.new("camelia sinensis (leave on)") }

    it "must fetch name" do
      ingredient.name.must_equal "camelia sinensis"
    end

    it "must fetch synonims" do
      ingredient.synonims.must_be_empty
    end

    it "must fetch details" do
      ingredient.details.must_equal "leave on"
    end
  end
end
