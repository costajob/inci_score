# frozen_string_literal: true

require 'helper'

describe InciScore::CLI do
  let(:io) { StringIO.new }

  it 'must warn if no inci is specified' do
    InciScore::CLI.new(args: ['aqua'], io: io, catalog: Stubs.catalog).call
    _(io.string).must_equal "Specify inci list as: --src='aqua, parfum, etc'\n"
  end

  it 'must print the help' do
    begin
      InciScore::CLI.new(args: %w[--help], io: io, catalog: Stubs.catalog).call
    rescue SystemExit
      _(io.string).must_equal "Usage: inci_score --src='aqua, parfum, etc'\n    -s, --src=SRC                    The INCI list: 'aqua, parfum, etc'\n    -h, --help                       Prints this help\n"
    end
  end

  it 'must call computer' do
    cli = InciScore::CLI.new(args: ['--src=aqua, parfum, peg-10'], io: io, catalog: {'aqua' => 0, 'parfum' => 0})
    cli.call
    _(io.string).must_equal "\nTOTAL SCORE:\n      \t100.0\nVALID STATE:\n      \tfalse\nCOMPONENTS:\n      \taqua\\n\tparfum\nUNRECOGNIZED:\n      \tpeg-10\n      \n"
  end
end
