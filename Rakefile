require 'bundler/gem_tasks'
require 'rake/testtask'

begin
  require 'rspec/core/rake_task'
  namespace :spec do
    RSpec::Core::RakeTask.new(:features) do |t|
      t.pattern = 'features/**/*_spec.rb'
    end
    RSpec::Core::RakeTask.new(:unit)

    task all: [:features, :unit]
  end

  task default: 'spec:all'
rescue LoadError
  p 'RSpec is not available on this machine'
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/features/**/*_test.rb'
  t.warning = false
end
