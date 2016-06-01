require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  namespace :spec do
    RSpec::Core::RakeTask.new(:features) do |t|
      t.pattern = 'features/**/*_spec.rb'
      t.rspec_opts = '--require features_helper'
    end
    RSpec::Core::RakeTask.new(:unit) do |t|
      t.rspec_opts = '--require spec_helper'
    end

    task all: [:features, :unit]
  end

  task default: 'spec:all'
rescue LoadError
  p 'RSpec is not available on this machine'
end
