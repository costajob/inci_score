# frozen_string_literal: true

require 'helper'
require 'inci_score/response'

describe InciScore::Response do
  let(:components) { [Stubs::Component.new('aqua', 0), Stubs::Component.new('dimethicone', 4), Stubs::Component.new('peg-10', 4)] }
  let(:response) { InciScore::Response.new(components: components, unrecognized: %w(noent1 noent2), score: 47.18, precision: 100.0) }

  it 'must return a JSON representation' do
    _(response.to_json).must_equal %({"components":[{"name":"aqua","hazard":0},{"name":"dimethicone","hazard":4},{"name":"peg-10","hazard":4}],"unrecognized":["noent1","noent2"],"score":47.18,"precision":100.0})
  end

  it 'must return a string representation' do
    _(response.to_s).must_equal "\nTOTAL SCORE:\n      \t47.18\nPRECISION:\n      \t100.0\nCOMPONENTS:\n      \taqua (0), dimethicone (4), peg-10 (4)\nUNRECOGNIZED:\n      \tnoent1, noent2\n      "
  end
end
