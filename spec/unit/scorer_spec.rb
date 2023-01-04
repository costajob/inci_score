# frozen_string_literal: true

require 'helper'
require 'inci_score/scorer'

describe InciScore::Scorer do
  it 'must compute the full score' do
    Stubs.hazards.each do |args|
      hazards, score = *args
      _(InciScore::Scorer.new(hazards).call).must_be_close_to score, 0.5
    end
  end
end
