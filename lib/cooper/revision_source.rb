module Cooper
  # Default revisions factory for cooper documents
  class RevisionSource
    def initialize
      @revision_id = 0
    end

    def new_revision(object)
      @revision_id += 1
      object.class
            .revision_fields
            .each_with_object({}) { |field, revision|
              revision[field] = object.send(field)
            }.tap { |revision| revision[:id] = @revision_id }
    end
  end
end
