require 'bundler/gem_tasks'

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
end

