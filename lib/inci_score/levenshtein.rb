module InciScore
  class Levenshtein
    def initialize(s, t)
      @s = s.downcase.unpack("U*")
      @t = t.downcase.unpack("U*")
    end

    def call
      n = @s.length
      m = @t.length

      return m if n.zero?
      return n if m.zero?

      d = Array::new(m+1) { |i| i }
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

String::class_eval do
  def distance(t)
    InciScore::Levenshtein::new(self, t).call
  end
end
