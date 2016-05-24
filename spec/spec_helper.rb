<<<<<<< HEAD
require 'cooper'
require 'rr'

RSpec.configure do |config|
  config.mock_with :rr
=======
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'cooper'

Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each do |f|
  require_relative f
>>>>>>> ec664d5e21ac4c8f6e74fe8461be71758ca93507
end
