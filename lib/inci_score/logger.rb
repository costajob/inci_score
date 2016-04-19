require 'logger'
require 'inci_score/config'

module InciScore
  module Logger
    extend self

    attr_accessor :logger

    def instance(options = {})
      file = options.fetch(:file) { Config::data['logger']['file'] }
      left = options.fetch(:left) { Config::data['logger']['left'] }
      size = options.fetch(:size) { Config::data['logger']['size'] }
      level = options.fetch(:level) { Config::data['logger']['level'] }
      @logger ||= ::Logger.new(file, left, size).tap do |logger|
        logger.level = level
      end
    end
  end
end
