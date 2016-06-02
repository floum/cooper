module Cooper
  # Internal class meant to find revisions based on options
  class RevisionFinder
    OPTIONS = [:time, :id].freeze
    METADATA_FIELDS = [:created_at, :id].freeze

    def initialize(document)
      @document = document
    end

    def find(options = {})
      return nil if (OPTIONS & options.keys).empty?
      revision = revisions.find(&search(options))
      revision.reject { |key, _| METADATA_FIELDS.include?(key) } if revision
    end

    private

    def revisions
      document.revisions
    end

    def search(options)
      by_time(options.fetch(:time) { return by_id(options[:id]) })
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
