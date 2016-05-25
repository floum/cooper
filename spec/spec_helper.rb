require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'cooper'

RSpec.configure do
  Mongoid.load!(File.join(File.expand_path(__dir__), 'support', 'mongoid.yml'), :development)
end
