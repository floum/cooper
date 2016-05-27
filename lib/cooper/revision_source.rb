module Cooper
  # Default revisions factory for cooper documents
  class RevisionSource
    def initialize
      @source = Redis.new
    end

    def revision_id
      @source.get('revision_id').to_i
    end

    def new_revision(object)
      object.class
            .revision_fields
            .each_with_object({}) { |field, revision|
              revision[field] = object.send(field)
            }.tap { |revision| revision[:id] = revision_id + 1 }
    end

    def notify_save
      @source.incr 'revision_id'
    end
  end
end
