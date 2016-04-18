module InciScore
  class Normalizer
    NEW_LINE = "\\\\n".freeze
    SPACE = ' '.freeze
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
      @rules = options.fetch(:rules) { %i{inline down replace split behead strip purge} }
    end

    def call
      @rules.each { |rule| send(rule) }
    rescue NameError => e
      raise NoentRuleError, e, e.backtrace
    end

    private

    def inline
      @src.tr!(NEW_LINE, SPACE)
    end

    def down
      @src.downcase!
    end

    def replace
      REPLACEMENTS.each do |r|
        @src.tr!(r[0], r[1])
      end
    end

    def split
      counted = SPACERS.reduce({}) { |acc,s| acc[s] = @src.count(s); acc }
      return if counted.values.all?(&:zero?)
      spacer = counted.max_by(&:last).first
      @src = @src.split(spacer)
    end

    def behead
      @src = Array(@src)
      return if @src[0].count(TITLE_SEP) == 0
      _, @src[0] = @src[0].split(TITLE_SEP)
    end

    def strip
      Array(@src).each(&:strip!)
    end

    def purge
      @src = Array(@src)
      @src.reject!(&:empty?)
      @src.each { |s| s.gsub!(REMOVALS, '') }
    end
  end
end
