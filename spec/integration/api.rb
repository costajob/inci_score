require 'spec_helper'
require 'inci_score/api/v1/app'

include Rack::Test::Methods

def app
  InciScore::API::V1::App
end

describe InciScore::API::V1::App do
  let(:path) { File::expand_path('../../../sample', __FILE__) }

  Stubs::API::sources.each_with_index do |record, i|
    it "must get inci score from record[#{i}]" do
      get '/v1/compute', src: record.src
      assert last_response.ok?
      last_response.content_type.must_equal 'application/json'
      body = JSON::parse(last_response.body)
      body.fetch('score').must_be_close_to record.score, 0.5
      body.fetch('valid').must_equal record.valid
    end
  end
end
