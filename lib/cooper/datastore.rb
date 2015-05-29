require 'json'

module Cooper
  # Interface class for the cooper data store
  class DataStore < File
    LOCATION = "#{ENV['HOME']}/.cooper_item"

    def self.open
      super(LOCATION, 'a+')
    end

    def reset
      truncate(0)
    end

    def <<(attributes)
      puts attributes.to_json
    end

    def read(revision)
      readlines[0..revision]
        .each_with_object({}) { |line, item| item.merge!(JSON.parse(line)) }
        .reject { |_, v| v.nil? }
    end
  end
end
