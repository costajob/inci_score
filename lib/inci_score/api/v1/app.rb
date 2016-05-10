require 'roda'
require 'inci_score'

module InciScore
  module API
    module V1
      class App < Roda
        plugin :json

        route do |r|
          r.on 'v1' do

            @src = r['src']
            break unless @src

            r.post 'compute' do
              c = InciScore::Computer::new(src: @src.fetch(:tempfile).path)
              c.call.to_h
            end
          end
        end
      end
    end
  end
end
