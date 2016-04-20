require 'bench_helper'
require 'inci_score/distance'

using InciScore::Fuzziness

Benchmark::ips do |x| 
  x.report("Levenshtein of '#{Bench::S}' and '#{Bench::T}'") do
    Bench::S.levenshtein(Bench::T)
  end

  x.report("Metaphone of '#{Bench::S}'") do
    Bench::S.metaphone
  end

  x.report("Assonance of '#{Bench::S}' and '#{Bench::T}'") do
    Bench::S.assonant?(Bench::T)
  end

  x.report("Distance of '#{Bench::S}' and '#{Bench::T}'") do
    Bench::S.distance(Bench::T)
  end

  x.report("Assonant distance of '#{Bench::S}' and '#{Bench::T}'") do
    Bench::S.distance(Bench::T, true)
  end
end
