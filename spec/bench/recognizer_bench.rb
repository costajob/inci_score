require 'bench_helper'
require 'inci_score/recognizer'

Benchmark::ips do |x| 
  x.report('apply_rules') do
    r = InciScore::Recognizer::new(ingredient: 'aqua/water', catalog: Stubs::Computer::catalog)
    r.send(:apply_rules)
  end
end
