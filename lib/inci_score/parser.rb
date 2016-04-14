require 'nokogiri'
require 'inci_score/component'

module InciScore
  class Parser
    SEMAPHORES = %w[vv v g r rr]
    BIODIZIONARIO_URL = "http://www.biodizionario.it/biodizio.php".freeze
    CSS_QUERY = 'table[width="751"] > tr > td img'.freeze

    def initialize(options = {} )
      doc = options.fetch(:doc) { open(BIODIZIONARIO_URL) }
      @doc = Nokogiri::HTML(doc)
      @entity = options.fetch(:entity) { InciScore::Component }
    end

    def call
      @doc.css(CSS_QUERY).map do |img|
        hazard = semaphore(img.attr('src'))
        name = img.next_sibling.next_sibling
        desc = name.next_sibling.next_sibling
        name, desc = desc, name if swap?(desc.text)
        @entity::new(hazard: SEMAPHORES.index(hazard), name: normalize(name), desc: normalize(desc))
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
