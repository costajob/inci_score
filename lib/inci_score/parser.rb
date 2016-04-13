require 'nokogiri'

module InciScore
  class Parser
    SEMAPHORES = %w[vv v g r rr]
    CSS_QUERY = 'table[width="751"] > tr > td img'.freeze

    def initialize(io)
      @doc = Nokogiri::HTML(io)
    end

    def call
      @doc.css(CSS_QUERY).map do |img|
        hazard = semaphore(img.attr('src'))
        name = img.next_sibling.next_sibling
        desc = name.next_sibling.next_sibling
        name, desc = desc, name if swap?(desc.text)
        { hazard: SEMAPHORES.index(hazard), name: normalize(name), desc: normalize(desc) }
      end
    end

    private

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
