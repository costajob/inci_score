# frozen_string_literal: true

require 'helper'
require 'inci_score/normalizer'

describe InciScore::Normalizer do
  it 'must raise an argument error for missing src' do
    _{ InciScore::Normalizer.new }.must_raise ArgumentError
  end

  it 'must apply all rules to fetch ingredients' do
    Stubs::SOURCES.each_with_index do |src, i|
      _(InciScore::Normalizer.new(src: src).call).must_equal Stubs::INGREDIENTS[i]
    end
  end

  it 'must apply custom rules' do
    custom = [->(src) { src.upcase }, ->(src) { src.split('-').map(&:strip) }]
    normalizer = InciScore::Normalizer.new(src: 'aqua/water - parfum - magnesium', rules: custom)
    _(normalizer.call).must_equal %w[AQUA/WATER PARFUM MAGNESIUM]
  end
end
