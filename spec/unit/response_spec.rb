# frozen_string_literal: true

require 'helper'
require 'inci_score/response'

describe InciScore::Response do
  let(:response) { InciScore::Response.new(components: %w(aqua dimethicone peg-10), score: 47.18, valid: true, precision: 100.0) }

  it 'must return a JSON representation' do
    _(response.to_json).must_equal "{\"components\":[\"aqua\",\"dimethicone\",\"peg-10\"],\"unrecognized\":[],\"score\":47.18,\"valid\":true,\"precision\":100.0}"
  end

  it 'must return a string representation' do
    _(response.to_s).must_equal "\nTOTAL SCORE:\n      \t47.18\nVALID STATE:\n      \ttrue\nPRECISION:\n      \t100.0\nCOMPONENTS:\n      \taqua\\n\tdimethicone\\n\tpeg-10\nUNRECOGNIZED:\n      \n      "
  end
end
