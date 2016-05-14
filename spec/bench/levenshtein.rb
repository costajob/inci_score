require 'spec_helper'
require 'inci_score/levenshtein'

Benchmark::ips do |x| 
  Stubs::Levenshtein::records.each do |record|
    x.report(record.s) do
      InciScore::Levenshtein::new(record.s, record.t).call
    end
  end
end
