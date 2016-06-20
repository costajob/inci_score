require 'spec_helper'
require 'inci_score/recognizer'

Benchmark::ips do |x| 
  InciScore::Recognizer::DEFAULTS.each do |rule|
    x.report(rule) do
      InciScore::Recognizer.new(ingredient: 'aqua', catalog: Stubs::Computer::catalog, rules: [rule]).call
    end
  end

  x.compare!
end
