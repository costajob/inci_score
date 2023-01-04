# frozen_string_literal: true

require 'optparse'
require 'inci_score/computer'

module InciScore
  class CLI
    attr_reader :args, :io, :catalog
    attr_accessor :src

    def initialize(args:, io: STDOUT, catalog: InciScore::Catalog.fetch)
      @args = args
      @io = io
      @catalog = catalog
      @src = nil
    end

    def call(computer_klass: Computer)
      parser.parse!(args)
      return io.puts(%q{Specify inci list as: --src='aqua, parfum, etc'}) unless src
      io.puts computer_klass.new(src: src, catalog: catalog).call
    end

    private def parser
      OptionParser.new do |opts|
        opts.banner = %q{Usage: inci_score --src='aqua, parfum, etc'}

        opts.on('-sSRC', '--src=SRC', %q{The INCI list: 'aqua, parfum, etc'}) do |src|
          self.src = src
        end

        opts.on('-h', '--help', 'Prints this help') do
          io.puts opts
          exit
        end
      end
    end
  end
end
