require 'minitest/autorun'
require 'minitest/reporters'
require 'rr'
require 'database_cleaner'
require 'cooper'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

pwd = File.expand_path(__dir__)
mongoid_config = File.join(pwd, 'support', 'mongoid.yml')

Mongoid.load!(mongoid_config, :test)

DatabaseCleaner.strategy = :truncation

class Minitest::Spec
  before :each do
    DatabaseCleaner.start
    Cooper::REVISION_SOURCE.instance_eval { @source.set('revision_id', 0) }
    Cooper::REVISION_SOURCE.clock = Time
  end

  after :each do
    DatabaseCleaner.clean
  end
end
