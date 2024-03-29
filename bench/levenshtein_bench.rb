# frozen_string_literal: true

require 'helper'

s, t = 'agua', 'aqua'
lev_ruby = InciScore::Levenshtein.new(s, t)
lev_c = InciScore::LevenshteinC.new

Benchmark.ips do |x|
  x.report('levenshtein ruby') do
    lev_ruby.call
  end

  x.report('levenshtein C') do
    lev_c.call(s, s.size, t, t.size)
  end

  x.compare!
end
