$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'benchmark/ips'

module Bench
  extend self

  def argv
    @argv ||= Hash[ARGV.map { |arg| arg.split("=") }]
  end

  S = ENV.fetch('s') { argv.fetch('s') { 'bottle' } }
  T = ENV.fetch('t') { argv.fetch('t') { 'battley' } }
end
