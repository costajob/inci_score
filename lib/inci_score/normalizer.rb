require 'inci_score/logger'

module InciScore
  class Normalizer
    DEFAULTS = %i{inline down replace behead split purge strip}
    REPLACEMENTS = [
      [';', ','],
      ['.', ','],
      ['`', "'"],
      ['‘', "'"],
      ['—', '-'],
      ['|', 'l']
    ]
    TITLE_SEP = ':'.freeze
    SPACERS = %w[, - ']
    REMOVALS = /[^\w\s\/\\]/.freeze

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
      @src.tr!("\n", " ")
    end

    def down
      @src.downcase!
    end

    def replace
      REPLACEMENTS.each do |r|
        @src.tr!(r[0], r[1]) if @src.index(r[0])
      end
    end

    def behead
      return unless sep_index
      @src = @src[sep_index+1, @src.size]
    end

    def sep_index
      @src.index(TITLE_SEP)
    end

    def split
      counted = SPACERS.reduce({}) { |acc,s| acc[s] = @src.count(s); acc }
      return if counted.values.all?(&:zero?)
      spacer = counted.max_by(&:last).first
      @src = @src.split(spacer)
    end

    def strip
      @src = Array(@src)
      @src.each(&:strip!)
      @src.reject!(&:empty?)
    end

    def purge
      Array(@src).each { |s| s.gsub!(REMOVALS, '') }
    end
  end
end
