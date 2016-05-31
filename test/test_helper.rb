require 'minitest/autorun'
require 'minitest/reporters'
require 'rr'
require 'cooper'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]
