module Cooper
  # Internal class meant to find revisions based on options
  class RevisionFinder
    OPTIONS = [:time, :id].freeze
    METADATA_FIELDS = [:created_at, :id].freeze

    def initialize(document)
      @document = document
    end

    def find(options = {})
      raise ArgumentError unless (OPTIONS & options.keys).size == 1
      id = options.fetch(:id) {}
      time = options.fetch(:time) {}
      search = id ? by_id(id) : by_time(time)
      revision = revisions.find(&search)
      revision.reject { |key, _| METADATA_FIELDS.include?(key) } if revision
    end

    private

    def revisions
      document.revisions
    end

    def by_id(id)
      ->(revision) { revision[:id] <= id }
    end

    def by_time(time)
      ->(revision) { revision[:created_at] <= time }
    end

    attr_reader :document
  end
end
