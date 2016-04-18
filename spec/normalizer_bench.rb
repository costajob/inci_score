require 'bench_helper'
require 'inci_score/normalizer'

Benchmark::ips do |x| 
  %i{inline down replace split behead strip purge}.each do |rule|
    x.report(rule) do
      InciScore::Normalizer::new(src: Stubs::Normalizer::sources.first.src, rules: [rule]).call
    end
  end

  x.report('all') do
    InciScore::Normalizer::new(src: Stubs::Normalizer::sources.first.src).call
  end

  x.compare!
end
