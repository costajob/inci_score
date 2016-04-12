module InciScore
  class Metaphone
    Rule = Struct::new(:regexp, :phonetic) do
      def call(s)
        String(s).gsub!(regexp, phonetic)
      end
    end

    RULES = [
      Rule::new(/([bcdfhjklmnpqrstvwxyz])\1+/, '\1'),
      Rule::new(/^ae/, 'E'),
      Rule::new(/^[gkp]n/, 'N'),
      Rule::new(/^wr/, 'R'),
      Rule::new(/^x/, 'S'),
      Rule::new(/^wh/, 'W'),
      Rule::new(/mb$/, 'M'),
      Rule::new(/(?!^)sch/, 'SK'),
      Rule::new(/th/, '0'),
      Rule::new(/t?ch|sh/, 'X'),
      Rule::new(/c(?=ia)/, 'X'),
      Rule::new(/[st](?=i[ao])/, 'X'),
      Rule::new(/s?c(?=[iey])/, 'S'),
      Rule::new(/(ck?|q)/, 'K'),
      Rule::new(/dg(?=[iey])/, 'J'),
      Rule::new(/d/, 'T'),
      Rule::new(/g(?=h[^aeiou])/, ''),
      Rule::new(/gn(ed)?/, 'N'),
      Rule::new(/([^g]|^)g(?=[iey])/, '\1J'),
      Rule::new(/g+/, 'K'),
      Rule::new(/ph/, 'F'),
      Rule::new(/([aeiou])h(?=\b|[^aeiou])/, '\1'),
      Rule::new(/[wy](?![aeiou])/, ''),
      Rule::new(/z/, 'S'),
      Rule::new(/v/, 'F'),
      Rule::new(/(?!^)[aeiou]+/, '')
    ].map!(&:freeze)

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
      RULES.each { |rule| rule.call(t) }
    end

    def normalize!(t)
      t.downcase!
      t.gsub!(/[^a-z]/, '')
    end
  end
end
