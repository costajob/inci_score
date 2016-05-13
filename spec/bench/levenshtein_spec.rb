require 'spec_helper'
require 'inci_score/levenshtein'

Benchmark::ips do |x| 
  x.report('distance') do
    "aqua".distance("agua")
  end

  x.report('instance') do
    InciScore::Levenshtein::new("aqua", "agua").call
  end

  x.compare!
end
