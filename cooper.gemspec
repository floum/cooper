# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cooper/version'

Gem::Specification.new do |spec|
<<<<<<< HEAD
  spec.name          = 'cooper'
  spec.version       = Cooper::VERSION
  spec.authors       = ['efflamm castel']
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
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mongoid', '~> 5.1'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  spec.add_development_dependency 'rr'
=======
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
>>>>>>> ec664d5e21ac4c8f6e74fe8461be71758ca93507
end
