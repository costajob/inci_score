require 'bench_helper'
require 'inci_score/inci'

inci = Stubs::Inci::instance

Benchmark::ips do |x| 
  x.report('find') do
    inci.components
  end

  x.report('find exp') do
    inci.components(:find_exp)
  end

  x.compare!
end
