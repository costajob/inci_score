module Stubs
  Distance = Struct::new(:s, :t, :d)

  def self.single
    [Distance::new('elvis', 'elvis', 0),
     Distance::new('', '', 0),
     Distance::new('elvis', 'elviz', 1),
     Distance::new('king', 'the king', 4),
     Distance::new('graceland', 'disneyland', 5)]
  end

  def self.multiple
    [Distance::new('föo', 'foo', 1),
     Distance::new('français', 'francais', 1),
     Distance::new('français', 'franæais', 1),
     Distance::new("私の名前はポールです", "ぼくの名前はポールです", 2)]
  end

  def self.special
    [Distance::new("elvis\n", 'elvis', 1),
     Distance::new("\rking\n", "\nking", 2),
     Distance::new('teddybear', "\t\tteddybear\n", 3)]
  end
end
