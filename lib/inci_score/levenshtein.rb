module InciScore
  class Levenshtein
    def self.encode(s)
      String(s).encode!(Encoding::UTF_8).unpack("U*")
    end

    def initialize(t, s)
      @t = self.class.encode(t)
      @s = self.class.encode(s)
    end

    def call
      n = @s.length
      m = @t.length

      return m if n.zero?
      return n if m.zero?

      d = (0..m).to_a
      x = nil

      n.times do |i|
        e = i + 1
        m.times do |j|
          cost = @s[i] == @t[j] ? 0 : 1
          insertion = d[j + 1] + 1
          deletion = e + 1
          substitution = d[j] + cost
          x = insertion < deletion ? insertion : deletion
          x = substitution if substitution < x
          d[j] = e
          e = x
        end
        d[m] = x
      end

      return x
    end
  end
end
