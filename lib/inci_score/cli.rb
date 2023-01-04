# frozen_string_literal: true

require 'optparse'

module InciScore
  class CLI
    attr_reader :args, :io
    attr_accessor :src

    def initialize(args:, io: STDOUT)
      @args = args
      @io = io
      @src = nil
    end

    def call
      parser.parse!(args)
      return io.puts(%q{Specify inci list as: --src='aqua, parfum, etc'}) unless src
      computer = Computer.new(src: src)
      io.puts computer.call
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
