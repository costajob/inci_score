$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'rr'
require 'stubs'
require 'inci_score/logger'
require 'benchmark'

InciScore::Logger::logger = Logger::new(nil)
