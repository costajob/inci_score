$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'benchmark/ips'
require 'stubs'

module Bench
  extend self

  def argv
    @argv ||= Hash[ARGV.map { |arg| arg.split("=") }]
  end

  def fetch_n
    n = ENV.fetch('n') { argv.fetch('n') { rand(1..20).to_s } }
    n.size == 1 ? "0#{n}" : n
  end
  
  S = ENV.fetch('s') { argv.fetch('s') { 'bottle' } }
  T = ENV.fetch('t') { argv.fetch('t') { 'battley' } }
  N = fetch_n 
end
