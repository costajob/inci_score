require 'spec_helper'
require 'inci_score/computer'

describe InciScore::Computer do
  it 'must compute score by reading from image sources' do
    path = File::expand_path('../../../sample', __FILE__)
    Stubs::Computer::sources.each do |record|
      t = Benchmark::realtime { InciScore::Computer::new(src: File::join(path, record.src)).call.score.must_be_close_to record.score, 0.5 }
      puts "scanning #{record.src} took #{t.round(4)} seconds"
    end
  end 
end
