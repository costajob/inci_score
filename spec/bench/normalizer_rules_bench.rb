require "helper"

replacer = InciScore::Normalizer::Rules::Replacer
downcaser = InciScore::Normalizer::Rules::Downcaser
beheader = InciScore::Normalizer::Rules::Beheader
separator = InciScore::Normalizer::Rules::Separator
tokenizer = InciScore::Normalizer::Rules::Tokenizer
sanitizer = InciScore::Normalizer::Rules::Sanitizer
uniquifier = InciScore::Normalizer::Rules::Uniquifier
src = "‘INGREDIENTS‘:\n\nCOCO—BETANE,AQUA/WATER,DIMETHICONE"

Benchmark.ips do |x|
  x.report("replacer") do
    replacer.call(src)
  end

  x.report("downcaser") do
    downcaser.call(src)
  end

  x.report("beheader") do
    beheader.call(src)
  end

  x.report("separator") do
    separator.call(src)
  end

  x.report("tokenizer") do
    tokenizer.call(src)
  end

  x.report("sanitizer") do
    sanitizer.call(src)
  end

  x.report("uniquifier") do
    uniquifier.call(src)
  end
end
