require 'mongoid'
require 'redis'

require 'cooper/version'
require 'cooper/document'
require 'cooper/revision_source'

module Cooper
  REVISION_SOURCE = RevisionSource.new
end
