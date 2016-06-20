require 'spec_helper'
require 'inci_score/normalizer'

Benchmark::ips do |x| 
  InciScore::Normalizer::DEFAULTS.each do |rule|
    x.report(rule) do
      InciScore::Normalizer.new(src: Stubs::Normalizer::sources.sample.src, rules: [rule]).call
    end
  end

  x.compare!
end
