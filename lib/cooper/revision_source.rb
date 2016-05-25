module Cooper
  # Default revisions factory for cooper documents
  class RevisionSource
    def new_revision(object)
      object.class
            .revision_fields
            .each_with_object(OpenStruct.new) do |field, revision|
              revision.send("#{field}=", object.send(field))
            end
    end
  end
end
