module InciScore
  class Normalizer
    DEFAULTS = %w{replace down behead spacers split tokens}
    SPACER = ','.freeze
    TITLE_SEP = ':'
    SEP_MAX_INDEX = 50
    REPLACEMENTS = [
      [/\n+|\t+/, ' '],
      ['‘', "'"],
      ['—', '-'],
      ['(', 'C'],
      ['_', ' '],
      ['~', '-'],
      ['|', 'l'],
      [' I ', '/']
    ]
    SPACERS = ["; ", ". ", " ' ", " - ", " : "]
    REMOVALS = /[^\w\s]/.freeze

    attr_reader :src, :rules

    def initialize(options = {})
      @src = options[:src] || fail(ArgumentError, 'missing src')
      @rules = options.fetch(:rules) { DEFAULTS }
    end

    def call
      return @src if @src.instance_of?(Array)
      @rules.each { |rule| send(rule) }; @src
    end

    private

    def replace
      REPLACEMENTS.each do |r|
        @src.gsub!(r[0], r[1]) if @src.index(r[0])
      end
    end

    def down
      @src.downcase!
    end

    def behead
      sep_index = @src.index(TITLE_SEP)
      return if !sep_index || sep_index > SEP_MAX_INDEX
      @src = @src[sep_index+1, @src.size]
    end

    def spacers
      SPACERS.each do |spacer|
        @src.gsub!(spacer, SPACER)
      end
    end

    def split
      @src = @src.split(SPACER)
    end

    def tokens
      Array(@src).reject! do |token| 
        token.sub!(/\/.*/, '') if token.index('/')
        token.gsub!(REMOVALS, '')
        token.strip!
        token.empty?
      end
    end
  end
end
