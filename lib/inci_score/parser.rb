require 'nokogiri'
require 'open-uri'

module InciScore
  class Parser
    URI = "http://www.biodizionario.it/biodizio.php".freeze
    SEMAPHORES = %w[vv v g r rr]
    CSS_QUERY = 'table[width="751"] > tr > td img'.freeze

    def initialize(out = nil)
      @out = out || Thread::new { open(URI) }
    end

    def call
      @components ||= Nokogiri::HTML(doc).css(CSS_QUERY).inject({}) do |acc, img|
        hazard = semaphore(img.attr('src'))
        name = img.next_sibling.next_sibling
        desc = name.next_sibling.next_sibling
        name, desc = desc, name if swap?(desc.text)
        acc[normalize(name)] = SEMAPHORES.index(hazard)
        acc
      end
    end

    private

    def doc
      @doc ||= @out.respond_to?(:value) ? @out.value : @out
    end

    def semaphore(src)
      src.match(/(#{SEMAPHORES.join('|')}).gif$/)[1]
    end

    def normalize(node)
      node.text.strip.downcase
    end

    # adjust displaying issues on biodizionario
    def swap?(desc)
      desc == desc.upcase
    end
  end
end
