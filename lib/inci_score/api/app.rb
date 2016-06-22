require 'rack'
require 'inci_score'

module InciScore
  module API
    module App
      extend self

      def call(env)
        req = Rack::Request.new(env)
        src = req.params["src"]
        json = src ? Computer.new(src).call.to_json : %q({"error": "no valid source"})
        ['200', {'Content-Type' => 'application/json'}, [json]]
      end
    end
  end
end
