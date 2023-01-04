lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'inci_score/version'

Gem::Specification.new do |s|
  s.name = 'inci_score'
  s.version = InciScore::VERSION
  s.authors = ['costajob']
  s.email = ['costajob@gmail.com']
  s.summary = %q{A library that computes the hazard of cosmetic products components, based on the Biodizionario data.}
  s.homepage = 'https://github.com/costajob/inci_score.git'
  s.files = Dir.glob('{bin,lib}/**/*') + %w(LICENSE.txt README.md)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(spec)/})
  s.require_paths = ['lib']
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.7'
  s.add_runtime_dependency 'oj', '~> 3'
  s.add_runtime_dependency 'RubyInline', '~> 3'
  s.add_development_dependency 'bundler', '~> 2'
  s.add_development_dependency 'rake', '~> 13'
  s.add_development_dependency 'minitest', '~> 5'
  s.add_development_dependency 'benchmark-ips', '~> 2'
end
