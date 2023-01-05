# frozen_string_literal: true

require 'helper'
require 'inci_score/score'

describe InciScore::Score do
  it 'must compute score value accordingly' do
    _(InciScore::Score.new(3, 0.66).value).must_equal 2.34
  end

  it 'must return zero fr negative score' do
    _(InciScore::Score.new(0, 0.66).value).must_equal 0.0
  end
end
