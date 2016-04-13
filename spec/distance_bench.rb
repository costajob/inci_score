require 'bench_helper'
require 'inci_score/distance'

Benchmark::ips do |x| 
  x.report("Distance of '#{Bench::S}' and '#{Bench::T}'") do
    InciScore::Distance::new(Bench::S, Bench::T)
  end
end
