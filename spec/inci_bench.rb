require 'bench_helper'
require 'inci_score/inci'

inci = Stubs::Inci::instance

Benchmark::ips do |x| 
  x.report('find') do
    inci.components
  end
end
