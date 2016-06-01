require 'cooper'

pwd = File.expand_path(__dir__)
mongoid_config = File.join(pwd, 'support', 'mongoid.yml')

Mongoid.load!(mongoid_config, :test)

RSpec.configure do |config|
  config.before :each do
    Cooper::REVISION_SOURCE.instance_eval { @source.set('revision_id', 0) }
  end
end
