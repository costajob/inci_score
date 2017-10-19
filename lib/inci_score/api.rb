require "rack"
require "inci_score"

module InciScore
  module Api
    extend self

    def catalog
      @catalog ||= Catalog.fetch
    end

    def call(env)
      req = Rack::Request.new(env)
      src = req.params["src"]
      precise = req.params["precise"]
      json = src ? Computer.new(src: src, catalog: catalog, precise: !!precise).call.to_json : %q({"error": "no valid source"})
      ["200", {"Content-Type" => "application/json"}, [json]]
    end
  end
end
