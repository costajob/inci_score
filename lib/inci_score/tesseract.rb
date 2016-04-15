require 'inci_score/config'

module InciScore
  class Tesseract
    COMMAND = File::join(Config::data['tesseract']['path']).freeze
    
    class MissingInstallationError < StandardError; end

    def initialize(options = {})
      @src = options.fetch(:src) { fail ArgumentError, 'missing src'}
      @out = options.fetch(:out) { 'stdout'.freeze }
      @opts = options.fetch(:opts) { '' }
    end

    def call
      %x{#{COMMAND} #{@src} #{@out} #{@opts}}
    rescue StandardError
      raise MissingInstallationError, "install tesseract for your platform"
    end
  end
end
