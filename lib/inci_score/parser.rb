require 'nokogiri'
require 'inci_score/config'

module InciScore
  class Parser
    SEMAPHORES = %w[vv v g r rr]
    CSS_QUERY = 'table[width="751"] > tr > td img'.freeze

    def initialize(src = nil)
      @src = src || Thread::new { open(Config::BIODIZIO_URI) }
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
      @src.respond_to?(:value) ? @src.value : @src
    end

    def semaphore(src)
      src.match(/(#{SEMAPHORES.join('|')}).gif$/)[1]
    end

    def normalize(node)
      node.text.strip.downcase
    end

    def swap?(desc)
      return false if desc.empty?
      desc == desc.upcase
    end
  end
end
