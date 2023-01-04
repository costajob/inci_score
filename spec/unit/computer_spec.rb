# frozen_string_literal: true

require 'helper'

describe InciScore::Computer do
  let(:computer) { InciScore::Computer.new(src: Stubs.sources[0], catalog: Stubs.catalog) }

  it 'must collect components' do
    _(computer.components.map(&:name)).must_equal(['aqua', 'disodium laureth sulfosuccinate', 'cocamidopropyl betaine', 'disodium cocoamphodiacetate', 'glyceryl laurate', 'peg-7 glyceryl cocoate', 'sodium lactate', 'parfum', 'niacinamide', 'glycine', 'magnesium aspartate', 'alanine', 'lysine', 'leucine', 'allantoin', 'peg-150 distearate', 'peg-120 methyl glucose dioleate', 'phenoxyethanol', 'ci 61570'])
  end

  it 'must collect unrecognized components' do
    _(computer.unrecognized).must_equal %w[50]
  end

  it 'must detect valid state' do
    assert computer.valid?
  end

  it 'must compute the score' do
    _(computer.score).must_be_close_to 82, 0.5
  end

  it 'must return response' do
    _(computer.call).must_be_instance_of InciScore::Response
  end

  it 'must detect invalid state' do
    computer = InciScore::Computer.new(src: 'ingredients: aqua, noent1, noent2', catalog: Stubs.catalog)
    refute computer.valid?
  end

  it 'must overwrite tolerance' do
    computer = InciScore::Computer.new(src: 'ingredients: aqua, noent1, noent2', catalog: Stubs.catalog, tolerance: 75.0)
    assert computer.valid?
  end
end
