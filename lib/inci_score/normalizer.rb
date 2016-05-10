require 'inci_score/logger'

module InciScore
  class Normalizer
    DEFAULTS = %w{inline replace down behead spacers split synonym purge strip}
    SPACER = ','.freeze
    TITLE_SEP = ':'
    SEP_MAX_INDEX = 50
    REPLACEMENTS = [
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

    class NoentRuleError < NameError; end

    attr_reader :src, :rules

    def initialize(options = {})
      @src = options.fetch(:src) { fail ArgumentError, 'missing src' }
      @rules = options.fetch(:rules) { DEFAULTS }
    end

    def call
      return @src if @src.instance_of?(Array)
      @rules.each { |rule| send(rule) }; @src
    rescue NameError => e
      Logger::instance.error(e)
      raise NoentRuleError, e, e.backtrace
    end

    private

    def inline
      @src.tr!("\n\t", " ")
    end

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

    def synonym
      Array(@src).each { |s| s.sub!(/\/.*/, '') }
    end

    def purge
      Array(@src).each { |s| s.gsub!(REMOVALS, '') }
    end

    def strip
      Array(@src).each { |s| s.strip!; s.gsub!(/\s{2,}/, ' ') }.reject!(&:empty?)
    end
  end
end
