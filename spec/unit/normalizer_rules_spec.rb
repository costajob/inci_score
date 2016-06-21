require 'spec_helper'
require 'inci_score/normalizer_rules'

describe InciScore::Normalizer::Rules do
  it 'must replace invalid chars' do
    src = "‘ingredients‘:\n\n(OCO—BETANE -_AQUA I WATER\t\t~\n\ng|igeryn"
    rule = InciScore::Normalizer::Rules::Replacer.new(src)
    rule.call.must_equal %Q{'ingredients': COCO-BETANE - AQUA/WATER - gligeryn}
  end

  it 'must downcase the source' do
    src = 'AQUA, DIMETHICONE, PEG-10'
    rule = InciScore::Normalizer::Rules::Downcaser.new(src)
    rule.call.must_equal src.downcase
  end

  it 'must remove the head from the source' do
    src = 'ingredients: aqua, dimethicone, PEG-10'
    rule = InciScore::Normalizer::Rules::Beheader.new(src)
    rule.call.must_equal ' aqua, dimethicone, PEG-10'
  end

  it 'must return source if there is no title separator' do
    src = 'aqua, dimethicone, PEG-10'
    rule = InciScore::Normalizer::Rules::Beheader.new(src)
    rule.call.must_equal src
  end

  it 'must return source if title separator index is geater than max' do
    spacer = '*' * InciScore::Normalizer::Rules::Beheader::MAX_INDEX
    src = "#{spacer} aqua : water : dimethicone"
    rule = InciScore::Normalizer::Rules::Beheader.new(src)
    rule.call.must_equal src
  end

  it 'must replace separators with default char' do
    src = 'aqua; dimethicone : PEG-10 - magnesium. parfum'
    rule = InciScore::Normalizer::Rules::Separator.new(src)
    rule.call.must_equal 'aqua,dimethicone,PEG-10,magnesium,parfum'
  end

  it 'must remove alternates and special characters' do
    src = 'aqua/water , PEG&-10, magnesium$ , &/&$$£'
    rule = InciScore::Normalizer::Rules::Tokenizer.new(src)
    rule.call.must_equal %w[aqua PEG-10 magnesium]
  end
end

