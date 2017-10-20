require "optparse"
require "inci_score/computer"
require "inci_score/server"

module InciScore
  class CLI
    def initialize(args:, io: STDOUT, catalog: InciScore::Catalog.fetch)
      @args = args
      @io = io
      @catalog = catalog
      @src = nil
      @port = nil
    end

    def call(server_klass: Server, computer_klass: Computer)
      parser.parse!(@args)
      return server_klass.new(port: @port, preload: true).run if @port
      return @io.puts(%q{Specify inci list as: --src="aqua, parfum, etc"}) unless @src
      @io.puts computer_klass.new(src: @src, catalog: @catalog).call
    end

    private def parser
      OptionParser.new do |opts|
        opts.banner = %q{Usage: inci_score --src="aqua, parfum, etc"}

        opts.on("-sSRC", "--src=SRC", %q{The INCI list: "aqua, parfum, etc"}) do |src|
          @src = src
        end

        opts.on("--http=PORT", "Start HTTP server on the specified port") do |port|
          @port = port
        end

        opts.on("-h", "--help", "Prints this help") do
          @io.puts opts
          exit
        end
      end
    end
  end
end
