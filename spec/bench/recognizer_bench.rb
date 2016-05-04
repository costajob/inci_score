require 'bench_helper'
require 'inci_score/recognizer'

Benchmark::ips do |x| 
  x.report('recognizer') do
    InciScore::Recognizer::new('aqua/water', Stubs::Computer::catalog)
  end
end
