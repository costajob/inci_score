require 'bench_helper'
require 'inci_score/computer'

inci = Stubs::Computer::instance

Benchmark::ips do |x| 
  x.report('components') do
    inci.components
  end
end
