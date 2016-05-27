# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cooper/version'

Gem::Specification.new do |spec|
  spec.date = '2016-05-26'
  spec.required_ruby_version = '>= 2.3'

  spec.name          = 'cooper'
  spec.version       = Cooper::VERSION
  spec.authors       = ['Efflam Castel']
  spec.email         = ['efflamm.castel@gmail.com']

  spec.summary       = 'a revision database system built upon mongoid'
  spec.homepage      = 'https://github.com/floum/cooper'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://localhost'
  else
    raise 'Upgrade RubyGems to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0")
                                .reject { |f| f.match(%r{^(spec)/}) }
  spec.test_files = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mongoid', '~> 5.1'
  spec.add_runtime_dependency 'redis', '~> 3.3'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.5'

  spec.license = 'MIT'
end
