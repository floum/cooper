require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each do |f|
  require_relative f
end
