require 'spec_helper'
require 'inci_score/logger'

describe InciScore::Logger do
  it 'must return a logger instance' do
    InciScore::Logger::instance.must_be_instance_of Logger
  end

  it 'must memoize instance' do
    assert InciScore::Logger::instance.equal? InciScore::Logger::instance
  end

  it 'must take options' do
    assert InciScore::Logger::instance(level: 2).warn?
  end
end
