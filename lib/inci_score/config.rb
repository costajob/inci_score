require 'yaml'
require 'erb'

module InciScore
  module Config
    extend self

    BIODIZIO_URI = 'http://www.biodizionario.it/biodizio.php'.freeze
    CATALOG_YML = File::expand_path('../../../config/catalog.yml', __FILE__) 

    def catalog
      @catalog ||= YAML::load_file(CATALOG_YML)
    end
  end
end
