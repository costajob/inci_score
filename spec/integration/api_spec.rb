require 'spec_helper'
require 'inci_score/api/v1/app'

include Rack::Test::Methods

def app
  InciScore::API::V1::App
end

describe InciScore::API::V1::App do
  let(:path) { File::expand_path('../../../sample', __FILE__) }

  Stubs::Computer::sources.each do |record|
    it "should post #{record.src} imge to API to get inci score of #{record.score}" do
      upload = Rack::Test::UploadedFile::new(File::join(path, record.src))
      post '/v1/compute', file: upload
      assert last_response.ok?
      last_response.content_type.must_equal 'application/json'
      body = JSON::parse(last_response.body)
      body.fetch('score').must_be_close_to record.score, 0.5
    end
  end
end
