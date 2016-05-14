module InciScore
  class Tesseract
    BIN = File::join(Config::data['tesseract']['bin']).freeze
    
    class InstallationError < StandardError; end

    def initialize(options = {})
      @src = options.fetch(:src) { fail ArgumentError, 'missing src'}
      @out = options.fetch(:out) { 'stdout'.freeze }
      @opts = options.fetch(:opts) { '' }
    end

    def call(bin = BIN)
      `#{bin} #{@src} #{@out} #{@opts}`
    rescue StandardError => e
      raise InstallationError, 'please install tesseract for your platform'
    end
  end
end
