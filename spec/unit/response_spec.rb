# frozen_string_literal: true

require 'helper'
require 'inci_score/response'

describe InciScore::Response do
  it 'must return a JSON representation' do
    _(Stubs.response.to_json).must_equal %{{"components":["aqua","dimethicone","peg-10"],"unrecognized":[],"score":47.18034913243358,"valid":true}}
  end
end
