require 'roda'
require 'inci_score'

module InciScore
  module V1
    class App < Roda
      plugin :json

      route do |r|
        r.on 'v1' do

          @file = r['file']
          break unless @file

          r.post 'compute' do
            src = @file.fetch(:tempfile).path
            c = InciScore::Computer::new(src: src)
            c.call.to_h
          end
        end
      end
    end
  end
end
