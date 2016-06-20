require 'roda'
require 'inci_score'

module InciScore
  module API
    module V1
      class App < Roda
        plugin :json

        route do |r|
          r.on 'v1' do
            r.get 'compute' do
              c = Computer.new(src: r['src'])
              c.call.to_h
            end
          end
        end
      end
    end
  end
end
