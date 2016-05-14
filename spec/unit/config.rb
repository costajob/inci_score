require 'spec_helper'
require 'inci_score/config'

describe InciScore::Config do
  it 'must load configuration data as hash' do
    InciScore::Config::data.must_be_instance_of Hash
  end

  it 'must fetch data properly' do
    %w[biodizio tesseract].each do |k|
      assert InciScore::Config::data.has_key?(k)
    end
  end

  it 'must memoize data loading' do
    assert InciScore::Config::data.equal? InciScore::Config::data
  end
end
