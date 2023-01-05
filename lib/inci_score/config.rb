# frozen_string_literal: true

require 'yaml'

module InciScore
  module Config
    CATALOG = YAML::load_file(File::expand_path('../../../config/catalog.yml', __FILE__)).freeze
    CIR = File.readlines(File::expand_path('../../../config/cir', __FILE__)).freeze
    HAZARDS = YAML::load_file(File::expand_path('../../../config/hazards.yml', __FILE__)).freeze
  end
end
