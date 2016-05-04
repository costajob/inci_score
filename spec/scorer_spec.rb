require 'spec_helper'
require 'inci_score/scorer'

describe InciScore::Scorer do
  it 'must compute the full score' do
    Stubs::Scorer::hazards.each do |record|
      InciScore::Scorer::new(record.hazards).call.must_be_close_to record.score, 0.5
    end
  end
end
