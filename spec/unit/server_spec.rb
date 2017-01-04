require 'spec_helper'
require 'inci_score/server'

describe InciScore::Server do
  it 'must run with default options' do
    server = InciScore::Server.new(config_klass: Stubs::Configuration, 
                                   launcher_klass: Stubs::Launcher)
    config = server.run
    config.app.must_equal InciScore::Server::RACKUP_FILE
    config.host.must_equal "tcp://#{InciScore::Server::DEFAULT_HOST}:9292"
    config.min.must_equal "1"
    config.max.must_equal "2"
    config.wrks.must_equal Etc.nprocessors
    refute config.preload
  end

  it 'must run with custom options' do
    server = InciScore::Server.new(port: 9001, threads: "3:6", 
                                   workers: 1, preload: true,
                                   config_klass: Stubs::Configuration, 
                                   launcher_klass: Stubs::Launcher)
    config = server.run
    config.app.must_equal InciScore::Server::RACKUP_FILE
    config.host.must_equal "tcp://#{InciScore::Server::DEFAULT_HOST}:9001"
    config.min.must_equal "3"
    config.max.must_equal "6"
    config.wrks.must_be_nil
    assert config.preload
  end
end
