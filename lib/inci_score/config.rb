require 'yaml'
require 'erb'

module InciScore
  module Config
    extend self

    PATH = File::expand_path('../../../config/inci_score.yml', __FILE__)

    def data
      @data ||= YAML.load(ERB.new(File.read(PATH)).result)
    end

    ENV['TESSDATA_PREFIX'] = data.fetch('tesseract') { {} }.fetch('path') { '/usr/share/tesseract-ocr' } 
  end
end
