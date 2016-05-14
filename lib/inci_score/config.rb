require 'yaml'
require 'erb'

module InciScore
  module Config
    extend self

    PATH = File::expand_path('../../../config/inci_score.yml', __FILE__)
    CATALOG_YML = File::expand_path('../../../config/catalog.yml', __FILE__) 

    def data
      @data ||= YAML.load(ERB.new(File.read(PATH)).result)
    end

    def catalog
      @catalog ||= YAML::load_file(CATALOG_YML)
    end
  end
end
