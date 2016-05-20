require 'spec_helper'
require 'inci_score/levenshtein'

s, t = 'aqua', 'agua'

Benchmark::ips do |x| 
  %w[distance distance_utf8].each do |msg|
    x.report(msg) do
      s.send(msg, t)
    end
  end

  x.compare!
end
