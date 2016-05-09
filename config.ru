$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inci_score/api/v1/app'

run InciScore::API::V1::App.freeze.app
