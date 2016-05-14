require 'spec_helper'
require 'inci_score/computer'

Benchmark::ips do |x| 
  Stubs::Computer::sources.each do |record|
    x.report(record.name) do
      InciScore::Computer::new(src: record.src).call
    end
  end

  x.compare!
end
