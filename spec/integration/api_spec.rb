require 'spec_helper'
require 'inci_score/api/v1/app'

include Rack::Test::Methods

def app
  InciScore::API::V1::App
end

describe InciScore::API::V1::App do
  let(:path) { File::expand_path('../../../sample', __FILE__) }

  Stubs.sources.each_with_index do |src, i|
    status, score = Stubs.statuses[i], Stubs.scores[i]

    it "[#{i}] - must get a proper response" do
      get '/v1/compute', src: src
      assert last_response.ok?
      last_response.content_type.must_equal 'application/json'
      body = JSON::parse(last_response.body)
      body.fetch('score').must_be_close_to score, 0.5
      body.fetch('valid').must_equal status
    end
  end
end
