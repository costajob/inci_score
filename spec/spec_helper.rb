$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'rack/test'
require 'rr'
require 'stubs'
require 'inci_score/logger'

InciScore::Logger::logger = Logger::new(nil)
