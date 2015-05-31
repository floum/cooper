# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cooper/version'

Gem::Specification.new do |spec|
  spec.name = 'cooper'
  spec.version = Cooper::VERSION
  spec.required_ruby_version = '>= 2.2'
  spec.date = '2015-05-21'
  spec.summary = 'Cooper revisioning database project'
  spec.description = 'A revisioning database'
  spec.authors = ['Efflam Castel']
  spec.email = 'efflamm.castel@gmail.com'

  spec.files = `git ls-files -z`.split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files  = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.license = 'MIT'

  spec.add_runtime_dependency 'bundler', '~> 1.7'
  spec.add_runtime_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'rubocop', '~> 0.31'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  spec.add_development_dependency 'aruba', '~> 0.6'
  spec.add_development_dependency 'aruba-rspec', '~> 1.0'
end
