lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inci_score/version'

Gem::Specification.new do |s|
  s.name = "inci_score"
  s.version = InciScore::VERSION
  s.authors = ["costajob"]
  s.email = ["costajob@gmail.com"]
  s.summary = %q{A library that computes the hazard of cosmetic products components, based on the Biodizionario data.}
  s.homepage = "https://github.com/costajob/inci_score.git"
  s.license = "MIT"
  s.required_ruby_version = ">= 2.0.0"
  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|test|s|features)/}) }
  s.bindir = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "puma"
  s.add_runtime_dependency "roda"
  s.add_runtime_dependency "RubyInline"
  s.add_development_dependency "bundler", "~> 1.11"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "rr"
  s.add_development_dependency "benchmark-ips"
end
