# frozen_string_literal: true

require 'helper'

describe InciScore::Config do
  it 'must return catalog data' do
    _(InciScore::Config::CATALOG.size).must_equal 5042
  end

  it 'must return CIR data' do
    _(InciScore::Config::CIR.size).must_equal 6172
  end

  it 'must return hazards data' do
    _(InciScore::Config::HAZARDS.size).must_equal 31
  end
end
