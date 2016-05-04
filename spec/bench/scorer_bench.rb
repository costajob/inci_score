require 'bench_helper'
require 'inci_score/scorer'

Benchmark::ips do |x| 
  x.report('scorer') do
    InciScore::Scorer::new([0, 0, 0, 3, 1, 0, 2, 0, 0, 0, 0, 0, 0, 3, 3, 3, 2, 0]).call
  end
end
