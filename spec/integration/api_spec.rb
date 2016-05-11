require 'spec_helper'
require 'inci_score/api/v1/app'

include Rack::Test::Methods

def app
  InciScore::API::V1::App
end

describe InciScore::API::V1::App do
  let(:path) { File::expand_path('../../../sample', __FILE__) }

  Stubs::API::sources.each do |record|
    it "must get inci score from src (#{record.img})" do
      get '/v1/compute', src: record.src
      assert last_response.ok?
      last_response.content_type.must_equal 'application/json'
      body = JSON::parse(last_response.body)
      body.fetch('score').must_be_close_to record.score, 0.5
      body.fetch('valid').must_equal record.valid
    end

    it "must post #{record.img} img to API to compute inci score" do
      upload = Rack::Test::UploadedFile::new(File::join(path, record.img))
      post '/v1/tesseract', src: upload
      assert last_response.ok?
      last_response.content_type.must_equal 'application/json'
      body = JSON::parse(last_response.body)
      body.fetch('score').must_be_close_to record.score, 0.5
      body.fetch('valid').must_equal record.valid
    end
  end
end
