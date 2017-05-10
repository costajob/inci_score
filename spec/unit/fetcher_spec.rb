require "spec_helper"
require "inci_score/fetcher"

describe InciScore::Fetcher do
  let(:fetcher) { InciScore::Fetcher.new(Stubs.html) }

  it "must replace duplicate entries" do
    fetcher.call.size.must_equal 6
  end

  it "must collect component data properly" do
    fetcher.call.must_equal({"phosphatidylcholine"=>1, "1-naphthol"=>4, "1,2,4-benzenetriacetate"=>3, "1,3-bis-(2,4-diaminophenoxy)propane"=>0, "acetylated lanolin"=>2, "hexyldecyl laurate"=>2})
  end
end
