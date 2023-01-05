# frozen_string_literal: true

require 'helper'

describe InciScore::Normalizer::Rules do
  it 'must replace invalid chars' do
    src = "‘ingredients‘:\n\nCOCO—BETANE -_AQUA I WATER\t\t~\n\ng|igeryn"
    rule = InciScore::Normalizer::Rules::Replacer
    _(rule.call(src)).must_equal "'ingredients': COCO-BETANE - AQUA/WATER - gligeryn"
  end

  it 'must downcase the source' do
    src = 'AQUA, DIMETHICONE, PEG-10'
    rule = InciScore::Normalizer::Rules::Downcaser
    _(rule.call(src)).must_equal src.downcase
  end

  it 'must remove the head from the source' do
    src = 'ingredients: aqua, dimethicone, PEG-10'
    rule = InciScore::Normalizer::Rules::Beheader
    _(rule.call(src)).must_equal ' aqua, dimethicone, PEG-10'
  end

  it 'must return source if there is no title separator' do
    src = 'aqua, dimethicone, PEG-10'
    rule = InciScore::Normalizer::Rules::Beheader
    _(rule.call(src)).must_equal src
  end

  it 'must return source if title separator index is geater than max' do
    spacer = '*' * 50
    src = "#{spacer} aqua : water : dimethicone"
    rule = InciScore::Normalizer::Rules::Beheader
    _(rule.call(src)).must_equal src
  end

  it 'must replace separators with default char' do
    src = 'aqua; dimethicone : PEG-10 - magnesium. parfum'
    rule = InciScore::Normalizer::Rules::Separator
    _(rule.call(src)).must_equal 'aqua,dimethicone,PEG-10,magnesium,parfum'
  end

  it 'must tokenize string' do
    src = 'aqua/water , PEG-10, magnesium , &/&$$£'
    rule = InciScore::Normalizer::Rules::Tokenizer
    _(rule.call(src)).must_equal %w[aqua/water PEG-10 magnesium &/&$$£]
  end

  it 'must sanitize invalid characters' do
    src = %w[aqua/water PEG&-10 magnesium$ &/&$$£]
    rule = InciScore::Normalizer::Rules::Sanitizer
    _(rule.call(src)).must_equal %w[aqua/water PEG-10 magnesium /]
  end

  it 'must remove duplicates' do
    src = %w[aqua/water magnesium parfum/fragrance magnesium]
    rule = InciScore::Normalizer::Rules::Uniquifier
    _(rule.call(src)).must_equal %w[aqua/water magnesium parfum/fragrance]
  end
end
