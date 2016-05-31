require 'bundler/gem_tasks'
require 'rake/testtask'

namespace :test do
  Rake::TestTask.new(:features) do |t|
    t.libs << 'features'
    t.pattern = 'features/**/*_test.rb'
    t.warning = false
  end

  Rake::TestTask.new(:unit) do |t|
    t.libs << 'test'
    t.pattern = 'test/**/*_test.rb'
    t.warning = false
  end

  task all: [:features, :unit]
end

task default: 'test:all'
