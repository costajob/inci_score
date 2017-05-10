require "spec_helper"
require "inci_score/computer"

describe InciScore::Computer do
  let(:computer) { InciScore::Computer.new(src: Stubs.sources[0], catalog: Stubs.catalog) }

  it "must collect components" do
    computer.call.components.must_equal(["aqua", "disodium laureth sulfosuccinate", "cocamidopropyl betaine", "disodium cocoamphodiacetate", "glyceryl laurate", "peg-7 glyceryl cocoate", "sodium lactate", "parfum", "niacinamide", "glycine", "magnesium aspartate", "alanine", "lysine", "leucine", "allantoin", "peg-150 distearate", "peg-120 methyl glucose dioleate", "phenoxyethanol", "ci 61570"])
  end

  it "must collect unrecognized components" do
    computer.call.unrecognized.must_equal %w[50]
  end

  it "must detect valid state" do
    assert computer.call.valid
  end

  it "must compute the score" do
    computer.call.score.must_be_close_to 82, 0.5
  end

  it "must detect invalid state" do
    computer = InciScore::Computer.new(src: "ingredients: aqua, noent1, noent2", catalog: Stubs.catalog)
    refute computer.call.valid
  end

  it "must overwrite tolerance" do
    computer = InciScore::Computer.new(src: "ingredients: aqua, noent1, noent2", catalog: Stubs.catalog, tolerance: 75.0)
    assert computer.call.valid
  end

  it "must collect components precisely" do
    computer =  InciScore::Computer.new(src: "parfum, anine, ci 61570, ycine, magnesium aspartate, cinamide, peg-120 methyl glucose dioleate", catalog: Stubs.catalog, precise: true)
    computer.call.unrecognized.must_be_empty
  end
end
