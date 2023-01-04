# frozen_string_literal: true

require 'helper'

describe InciScore::Computer do
  let(:computer) { InciScore::Computer.new(src: Stubs::SOURCES[0], catalog: Stubs::CATALOG) }

  it 'must collect components' do
    _(computer.components.map(&:name)).must_equal(['aqua', 'disodium laureth sulfosuccinate', 'cocamidopropyl betaine', 'disodium cocoamphodiacetate', 'glyceryl laurate', 'peg-7 glyceryl cocoate', 'sodium lactate', 'parfum', 'niacinamide', 'glycine', 'magnesium aspartate', 'alanine', 'lysine', 'leucine', 'allantoin', 'peg-150 distearate', 'peg-120 methyl glucose dioleate', 'phenoxyethanol', 'ci 61570'])
  end

  it 'must collect unrecognized components' do
    _(computer.unrecognized).must_equal %w[50]
  end

  it 'must detect valid state' do
    assert computer.valid?
  end

  it 'must compute precision' do
    _(computer.precision).must_equal 95.0
  end

  it 'must compute the score' do
    _(computer.score).must_equal(81.97)
  end

  it 'must return response' do
    _(computer.call).must_be_instance_of InciScore::Response
  end
end
