require 'spec_helper'
require 'inci_score/metaphone'

describe InciScore::Metaphone do
  it 'must compute metaphone' do
    Stubs::Metaphone::records.each do |record|
      InciScore::Metaphone::new(record.s).call.must_equal record.phonetic
    end
  end

  it 'must normalize case' do
    InciScore::Metaphone::new('Elvis Presley').call.must_equal InciScore::Metaphone::new('elvis presley').call
  end

  it 'must strip non ascii characters' do
    InciScore::Metaphone::new('Elvis').call.must_equal InciScore::Metaphone::new('%^@#$Elˆ£viìs$;').call
  end
end
