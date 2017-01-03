require "optparse"
require "inci_score/computer"

module InciScore
  class CLI
    def initialize(args:, io: STDOUT, catalog: InciScore::Catalog.fetch)
      @args = args
      @io = io
      @catalog = catalog
      @src = nil
      @fresh = nil
    end

    def call(computer_klass = Computer, fetcher = Fetcher.new)
      parser.parse!(@args)
      return @io.puts("Specify inci list as: --src='aqua, parfum, etc'") unless @src
      @io.puts computer_klass.new(src: @src, catalog: catalog(fetcher)).call
    end

    private def parser
      OptionParser.new do |opts|
        opts.banner = %q{Usage: ./bin/inci_score --src='aqua, parfum, etc' --fresh}

        opts.on("-sSRC", "--src=SRC", "The INCI list: 'aqua, parfum, etc'") do |src|
          @src = src
        end

        opts.on("-f", "--fresh", "Fetch a fresh catalog from remote") do |fresh|
          @fresh = fresh
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
