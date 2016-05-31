require 'codeclimate-test-reporter'
SimpleCov.start unless CodeClimate::TestReporter.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'cooper'
require 'rr'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

module Mongoid::Document
  def save(options = {})
    true
  end
end
