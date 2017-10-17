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
  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|test|s|features)/}) }
  s.bindir = "bin"
  s.executables << "inci_score"
  s.require_paths = ["lib"]
  s.license = "MIT"
  s.required_ruby_version = ">= 2.2.2"

  s.add_runtime_dependency "puma", "~> 3"
  s.add_runtime_dependency "RubyInline", "~> 3"

  s.add_development_dependency "bundler", "~> 1.11"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "rack-test", "~> 0.6"
  s.add_development_dependency "benchmark-ips", "~> 2"
end
