require 'yaml'
require 'erb'

module InciScore
  module Catalog
    extend self

    YAML_PATH = File::expand_path('../../../config/catalog.yml', __FILE__) 

    def fetch(src = File.read(YAML_PATH))
      @catalog ||= YAML::load(src)
    end
  end
end
