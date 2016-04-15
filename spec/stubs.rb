module Stubs
  module Levenshtein
    extend self

    Stub = Struct::new(:s, :t, :distance)

    def records
      [Stub::new('', '', 0),
       Stub::new('elvis', 'elvis', 0),
       Stub::new('elvis', 'elviz', 1),
       Stub::new('king', 'the king', 4),
       Stub::new('graceland', 'disneyland', 5)]
    end

    def records_multiple
      [Stub::new('föo', 'foo', 1),
       Stub::new('français', 'francais', 1),
       Stub::new('français', 'franæais', 1),
       Stub::new("私の名前はポールです", "ぼくの名前はポールです", 2)]
    end

    def records_special
      [Stub::new("elvis\n", 'elvis', 1),
       Stub::new("\rking\n", "\nking", 2),
       Stub::new('teddybear', "\t\tteddybear\n", 3)]
    end
  end

  module Metaphone
    extend self

    Stub = Struct::new(:s, :phonetic)

    def records
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

  module Distance
    extend self

    Stub = Struct::new(:s, :t, :score)

    def records
      [Stub::new('battle', 'BAttlE', 10),
       Stub::new('battle', 'bottle', 10),
       Stub::new('battle', 'rattle', 9),
       Stub::new('battle', 'bottley', 9),
       Stub::new('battle', 'bottleneck', 5),
       Stub::new('last battle on earth', 'wtf?', 1)]
    end
  end

  module Parser
    extend self

    def html
      %q{<html><body><table border="0" width="751" cellspacing="0"  align="center"><tr><td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font color="#000000" size="4">Trovati 5034 risultati</font></b><br><br><img src=http://biodizionario.it/images/semafori/v.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px"> Emulsionante / Condizionante pelle</font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">PHOSPHATIDYLCHOLINE</font><br><img src=http://biodizionario.it/images/semafori/r.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1-NAPHTHOL</font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli</font><br><img src=http://biodizionario.it/images/semafori/r.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1,2,4-BENZENETRIACETATE </font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli </font><br><img src=http://biodizionario.it/images/semafori/vv.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1,3-BIS-(2,4-DIAMINOPHENOXY)PROPANE </font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli </font><br><img src=http://biodizionario.it/images/semafori/g.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">ACETYLATED LANOLIN </font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">antistatico / emolliente / emulsionante </font><br><img src=http://biodizionario.it/images/semafori/rr.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1-NAPHTHOL</font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli</font><br></td></tr></table></body></html>}
    end
  end
end
