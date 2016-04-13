module InciScore
  class Metaphone
    RULES = [
      [/([bcdfhjklmnpqrstvwxyz])\1+/, '\1'],
      [/^ae/, 'E'],
      [/^[gkp]n/, 'N'],
      [/^wr/, 'R'],
      [/^x/, 'S'],
      [/^wh/, 'W'],
      [/mb$/, 'M'],
      [/(?!^)sch/, 'SK'],
      [/th/, '0'],
      [/t?ch|sh/, 'X'],
      [/c(?=ia)/, 'X'],
      [/[st](?=i[ao])/, 'X'],
      [/s?c(?=[iey])/, 'S'],
      [/(ck?|q)/, 'K'],
      [/dg(?=[iey])/, 'J'],
      [/d/, 'T'],
      [/g(?=h[^aeiou])/, ''],
      [/gn(ed)?/, 'N'],
      [/([^g]|^)g(?=[iey])/, '\1J'],
      [/g+/, 'K'],
      [/ph/, 'F'],
      [/([aeiou])h(?=\b|[^aeiou])/, '\1'],
      [/[wy](?![aeiou])/, ''],
      [/z/, 'S'],
      [/v/, 'F'],
      [/(?!^)[aeiou]+/, '']
    ]

    def initialize(s)
      @tokens = String(s).strip.split(/\s+/)
    end

    def call
      @tokens.map { |t| transform!(t); t }.join(' ')
    end

    private
    
    def transform!(t)
      normalize!(t)
      apply_rules!(t)
      t.upcase!
    end

    def apply_rules!(t)
      RULES.each { |re, sub| t.gsub!(re, sub) }
    end

    def normalize!(t)
      t.downcase!
      t.gsub!(/[^a-z]/, '')
    end
  end
end
