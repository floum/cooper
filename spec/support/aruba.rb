require 'aruba/api'
require 'aruba/reporting'

RSpec.configure do |config|
  config.include Aruba::Api

  config.before :each do
    restore_env
    clean_current_dir
  end
end

require 'pathname'

root = Pathname.new(__FILE__).parent.parent.parent

ENV['PATH'] = "#{root.join('bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
