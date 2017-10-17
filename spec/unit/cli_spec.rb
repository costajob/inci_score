require "spec_helper"
require "inci_score/cli"

describe InciScore::CLI do
  let(:io) { StringIO.new }

  it "must warn if no inci is specified" do
    InciScore::CLI.new(args: ["aqua"], io: io, catalog: Stubs.catalog).call
    io.string.must_equal "Specify inci list as: --src=\"aqua, parfum, etc\"\n"
  end

  it "must print the help" do
    begin
      InciScore::CLI.new(args: %w[--help], io: io, catalog: Stubs.catalog).call
    rescue SystemExit
      io.string.must_equal "Usage: inci_score --src=\"aqua, parfum, etc\" --precise\n    -s, --src=SRC                    The INCI list: \"aqua, parfum, etc\"\n    -p, --precise                    Compute components more precisely (slower)\n        --http=PORT                  Start HTTP server on the specified port\n    -h, --help                       Prints this help\n"
    end
  end

  it "must call computer" do
    cli = InciScore::CLI.new(args: ["--src=aqua, parfum, peg-10"], io: io, catalog: {"aqua" => 0, "parfum" => 0})
    cli.call(computer_klass: Stubs::Computer)
    io.string.must_equal "{\"aqua\"=>0, \"parfum\"=>0}\n"
  end

  it "must run server" do
    cli = InciScore::CLI.new(args: ["--http=9292", "--src=agua"], io: io, catalog: Stubs.catalog)
    cli.call(server_klass: Stubs::Server).must_equal :run_on_port_9292
  end
end
