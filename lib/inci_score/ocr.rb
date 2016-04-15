require 'inci_score/config'

module InciScore
  class Ocr
    COMMAND = File::join(Config::data['tesseract']['path']).freeze

    def initialize(options = {})
      @src = options.fetch(:src) { fail ArgumentError, 'missing src'}
      @out = options.fetch(:out) { 'stdout'.freeze }
      @opts = options.fetch(:opts) { '' }
    end

    def call
      %x{#{COMMAND} #{@src} #{@out} #{@opts}}
    end
  end
end
