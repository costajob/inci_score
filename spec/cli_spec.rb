# frozen_string_literal: true

require 'helper'

describe InciScore::CLI do
  let(:io) { StringIO.new }

  it 'must warn if no inci is specified' do
    InciScore::CLI.new(args: ['aqua'], io: io).call
    _(io.string).must_equal "Specify INCI list as: --src='aqua, parfum, etc'\n"
  end

  it 'must print the help' do
    begin
      InciScore::CLI.new(args: %w[--help], io: io).call
    rescue SystemExit
      _(io.string).must_equal "Usage: inci_score --src='aqua, parfum, etc'\n    -s, --src=SRC                    The INCI list: 'aqua, parfum, etc'\n    -h, --help                       Prints this help\n"
    end
  end

  it 'must call computer' do
    cli = InciScore::CLI.new(args: ['--src=aqua, parfum, peg-10, bha'], io: io)
    cli.call
    _(io.string).must_equal "\nTOTAL SCORE:\n      \t50.79\nPRECISION:\n      \t100.0\nCOMPONENTS:\n      \taqua (0), parfum (3), peg-10 (3), bha (4)\n"
  end
end
