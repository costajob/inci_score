require "etc"
require "puma/launcher"
require "puma/configuration"

module InciScore
  class Server
    RACKUP_FILE = File.expand_path("../../../config.ru", __FILE__)
    DEFAULT_HOST = "0.0.0.0"

    def initialize(port: 9292, threads: "1:2", workers: Etc.nprocessors, preload: false, 
                   config_klass: Puma::Configuration, launcher_klass: Puma::Launcher)
      @port = port
      @workers = workers
      @threads = threads.split(":")
      @preload = preload
      @config_klass = config_klass
      @launcher_klass = launcher_klass
    end

    def run
      launcher.run
    end

    private def launcher
      @launcher_klass.new(config)
    end

    private def config
      @config_klass.new do |c|
        c.rackup RACKUP_FILE
        c.bind "tcp://#{DEFAULT_HOST}:#{@port}"
        c.workers @workers if workers?
        c.threads(*@threads)
        c.preload_app! if @preload
      end
    end

    private def workers?
      @workers > 1 && !java? && !windows?
    end

    private def java?
      RUBY_VERSION == "java"
    end

    private def windows?
      Gem.win_platform?
    end
  end
end
