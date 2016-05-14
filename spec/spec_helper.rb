$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'minitest/autorun'
require 'rack/test'
require 'rr'
require 'benchmark/ips'
require 'stubs'
