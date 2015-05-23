# TODO : add files and stuff from bundler
Gem::Specification.new do |spec|
  spec.name = 'cooper'
  spec.version = '0.0.0'
  spec.date = '2015-05-21'
  spec.summary = 'Cooper revisioning database project'
  spec.description = 'A revisioning database'
  spec.authors = ['Efflam Castel']
  spec.email = 'efflamm.castel@gmail.com'
  spec.files =
    `git ls-files -z`.split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables << 'cooper'
  spec.license = 'MIT'

  spec.add_runtime_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'rubocop', '~> 0.31'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  spec.add_development_dependency 'aruba', '~> 0.6'
  spec.add_development_dependency 'aruba-rspec', '~> 1.0'
end
