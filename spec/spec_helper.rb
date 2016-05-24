require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'cooper'
require 'rr'

RSpec.configure do |config|
  config.mock_with :rr
end
