require "inline"

module InciScore
  class LevenshteinC
    C_PROGRAM = File::expand_path("../../../ext/levenshtein.c", __FILE__)

    inline(:C) do |builder|
      builder.c File::read(C_PROGRAM) 
    end
  end

  class Levenshtein
    def initialize(s, t)
      @s = s.downcase.unpack("U*")
      @t = t.downcase.unpack("U*")
    end

    def call
      n, m = @s.length, @t.length

      return 0 if @s == @t
      return m if n.zero?
      return n if m.zero?

      d = Array.new(m+1) { |i| i }
      x = nil

      n.times do |i|
        e = i + 1
        m.times do |j|
          c = @s[i] == @t[j] ? 0 : 1
          ins = d[j + 1] + 1
          del = e + 1
          sub = d[j] + c
          x = ins < del ? ins : del
          x = sub if sub < x
          d[j] = e
          e = x
        end
        d[m] = x
      end
      x
    end
  end
end

