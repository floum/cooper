require 'aruba'
require 'aruba/api'

RSpec.configure do |config|
  config.include Aruba::Api

  config.before :each do
    setup_aruba
  end
end
