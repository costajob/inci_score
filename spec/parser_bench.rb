require 'bench_helper'
require 'inci_score/parser'

Benchmark::ips do |x| 
  x.report('HTML parser') do
    InciScore::Parser::new(doc: Stubs::Parser::html).call
  end
end
