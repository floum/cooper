require 'cooper/version'
require 'cooper/datastore'

# Cooper Database Engine Module
module Cooper
  def self.reset
    datastore(&:reset)
  end

  def self.read(revision = -1)
    datastore do |datastore|
      datastore.read(revision)
    end
  end

  def self.update(changes)
    datastore do |datastore|
      datastore << changes
    end
  end

  def self.delete(attribute)
    update(attribute => nil)
  end

  private

  def self.datastore
    datastore = DataStore.open
    yield(datastore)
  ensure
    datastore.close
  end
end
