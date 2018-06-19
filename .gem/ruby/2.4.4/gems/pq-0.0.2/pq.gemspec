# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'pq'

Gem::Specification.new do |spec|
  spec.name          = 'pq'
  spec.version       = PQ::VERSION
  spec.authors       = ['Andrey Zinenko']
  spec.email         = ['andrew@izinenko.ru']
  spec.summary       = 'Priority queue / heap implementation'
  spec.description   = 'Priority queue / heap implementation'
  spec.homepage      = 'https://github.com/zinenko/pq'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'

  spec.add_development_dependency 'rubocop', '0.49.1'
  spec.add_development_dependency 'benchmark-ips'
end
