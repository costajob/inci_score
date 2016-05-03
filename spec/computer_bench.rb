require 'bench_helper'
require 'inci_score/computer'

Benchmark::ips do |x| 
  x.report('call') do
    Stubs::Computer::instance.call
  end
end
