require 'spec_helper'
require 'inci_score/tesseract'

describe InciScore::Tesseract do
  it 'must rase an argument error for missing src' do
    -> { InciScore::Tesseract::new.call }.must_raise ArgumentError
  end

  it 'must rais an installation error for missing program' do
    -> { InciScore::Tesseract::new(src: './sample/01.jpg').call(:noent) }.must_raise InciScore::Tesseract::InstallationError
  end

  it 'must call command properly' do
    t = InciScore::Tesseract::new(src: './sample/01.jpg', opts: '-l eng -psm 7')
    def t.`(s); s; end
    t.call.must_equal '/usr/bin/tesseract ./sample/01.jpg stdout -l eng -psm 7'
  end
end
