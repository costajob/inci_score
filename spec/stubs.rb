module Stubs

  module Levenshtein
    extend self

    Stub = Struct::new(:s, :t, :distance)

    def single
      [Stub::new('', '', 0),
       Stub::new('elvis', 'elvis', 0),
       Stub::new('elvis', 'elviz', 1),
       Stub::new('king', 'the king', 4),
       Stub::new('graceland', 'disneyland', 5)]
    end

    def multiple
      [Stub::new('föo', 'foo', 1),
       Stub::new('français', 'francais', 1),
       Stub::new('français', 'franæais', 1),
       Stub::new("私の名前はポールです", "ぼくの名前はポールです", 2)]
    end

    def special
      [Stub::new("elvis\n", 'elvis', 1),
       Stub::new("\rking\n", "\nking", 2),
       Stub::new('teddybear', "\t\tteddybear\n", 3)]
    end
  end

  module Metaphone
    extend self

    Stub = Struct::new(:s, :phonetic)

    def phonetics
      [Stub::new('anastha', 'ANS0'),
       Stub::new('davis-carter', 'TFSKRTR'),
       Stub::new('escarmant', 'ESKRMNT'),
       Stub::new('mccall', 'MKL'),
       Stub::new('mccrorey', 'MKRR'),
       Stub::new('merseal', 'MRSL'),
       Stub::new('pieurissaint', 'PRSNT'),
       Stub::new('rotman', 'RTMN'),
       Stub::new('schevel', 'SXFL'),
       Stub::new('schrom', 'SXRM'),
       Stub::new('seal', 'SL'),
       Stub::new('sparr', 'SPR'),
       Stub::new('starleper', 'STRLPR'),
       Stub::new('thrash', '0RX'),
       Stub::new('logging', 'LKNK'),
       Stub::new('logic', 'LJK'),
       Stub::new('judges', 'JJS'),
       Stub::new('shoos', 'XS'),
       Stub::new('shoes', 'XS'),
       Stub::new('chute', 'XT'),
       Stub::new('schuss', 'SXS'),
       Stub::new('otto', 'OT'),
       Stub::new('eric', 'ERK'),
       Stub::new('buck', 'BK'),
       Stub::new('cock', 'KK'),
       Stub::new('dave', 'TF'),
       Stub::new('catherine', 'K0RN'),
       Stub::new('katherine', 'K0RN'),
       Stub::new('aubrey', 'ABR'),
       Stub::new('bryan', 'BRYN'),
       Stub::new('bryce', 'BRS'),
       Stub::new('steven', 'STFN'),
       Stub::new('richard', 'RXRT'),
       Stub::new('heidi', 'HT'),
       Stub::new('auto', 'AT'),
       Stub::new('maurice', 'MRS'),
       Stub::new('randy', 'RNT'),
       Stub::new('cambrillo', 'KMBRL'),
       Stub::new('brian', 'BRN'),
       Stub::new('ray', 'R'),
       Stub::new('geoff', 'JF'),
       Stub::new('bob', 'BB'),
       Stub::new('aha', 'AH'),
       Stub::new('aah', 'A'),
       Stub::new('paul', 'PL'),
       Stub::new('battley', 'BTL'),
       Stub::new('wrote', 'RT'),
       Stub::new('this', '0S')]
    end
  end

  module Fuzziness
    extend self

    Stub = Struct::new(:s, :t, :score, :delta)

    def distances
      [Stub::new('battle', 'BAttlE', 100, 0),
       Stub::new('battle', 'bottle', 87, 0.1),
       Stub::new('battle', 'rattle', 79.5, 0.1),
       Stub::new('battle', 'bottley', 54.2, 0.1),
       Stub::new('battle', 'bottleneck', 21.2, 0.1),
       Stub::new('last battle on earth', 'wtf?', 11.5, 0.1)]
    end
  end
end
