require 'spec_helper'
require 'inci_score/fuzziness'

using InciScore::Fuzziness

describe InciScore::Fuzziness do
  it 'must calculate edit distance' do
    'elvis'.distance('Elviz').must_equal 1
  end
end
