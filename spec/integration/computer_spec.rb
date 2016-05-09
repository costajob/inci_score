require 'spec_helper'
require 'inci_score/computer'

describe InciScore::Computer do
  let(:path) { File::expand_path('../../../sample', __FILE__) }

  Stubs::Computer::sources.each do |record|
    it "must compute the inco score of #{record.score} by scanning #{record.src}" do
      InciScore::Computer::new(src: File::join(path, record.src)).call.score.must_be_close_to record.score, 0.5
    end
  end 
end
