module Cooper
  class RevisionFinder

    OPTIONS = [:time, :id]
    METADATA_FIELDS = [:created_at, :id]

    def initialize(document)
      @document = document
    end

    def find(options = {})
      raise ArgumentError unless (OPTIONS & options.keys).size == 1
      id = options.fetch(:id) {}
      time = options.fetch(:time) {}
      if id
        revision = document.revisions.find { |revision| revision[:id] <= id }
      else
        revision = document.revisions.find { |revision| revision[:created_at] <= time }
      end
      revision.reject { |key, _| METADATA_FIELDS.include?(key) } if revision
    end
    
    private

    attr_reader :document
  end
end
