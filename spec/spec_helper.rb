require 'codeclimate-test-reporter'
SimpleCov.start unless CodeClimate::TestReporter.start

require 'cooper'

pwd = File.expand_path(__dir__)
mongoid_config = File.join(pwd, 'support', 'mongoid.yml')

Mongoid.load!(mongoid_config, :development)
