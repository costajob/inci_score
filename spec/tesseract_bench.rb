require 'tesseract-ocr'
require 'rtesseract'
require 'bench_helper'
require 'inci_score/config'


img_path = File::expand_path("../../sample/inci_#{Bench::N}.jpg", __FILE__)
puts "Scanning: #{img_path}"

Benchmark::ips do |x| 
  x.report(Tesseract) do
    Tesseract::Engine.new.text_for(img_path)
  end

  x.report(RTesseract) do
    RTesseract.new(img_path).to_s
  end

  x.report('RAW') do
    %x{tesseract #{img_path} stdout}
  end

  x.compare!
end
