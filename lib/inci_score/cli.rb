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
      @fresh = nil
      @port = nil
      @precise = nil
    end

    def call(server_klass: Server, computer_klass: Computer, fetcher: Fetcher.new)
      parser.parse!(@args)
      return server_klass.new(port: @port, preload: true).run if @port
      return @io.puts(%q{Specify inci list as: --src="aqua, parfum, etc"}) unless @src
      @io.puts computer_klass.new(src: @src, catalog: catalog(fetcher), precise: @precise).call
    end

    private def parser
      OptionParser.new do |opts|
        opts.banner = %q{Usage: inci_score --src="aqua, parfum, etc" --fresh --precise}

        opts.on("-sSRC", "--src=SRC", %q{The INCI list: "aqua, parfum, etc"}) do |src|
          @src = src
        end

        opts.on("-f", "--fresh", "Fetch a fresh catalog from remote") do |fresh|
          @fresh = fresh
        end

        opts.on("-p", "--precise", "Compute components more precisely (slower)") do |precise|
          @precise = precise
        end

        opts.on("--http=PORT", "Start Puma server on the specified port") do |port|
          @port = port
        end

        opts.on("-h", "--help", "Prints this help") do
          @io.puts opts
          exit
        end
      end
    end

    private def catalog(fetcher)
      return @catalog unless @fresh
      fetcher.call
    end
  end
end
