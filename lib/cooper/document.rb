module Cooper
  # Mongoid Document compliant with Revisions
  module Document
    extend ActiveSupport::Concern
    include Mongoid::Document

    attr_accessor :revision_source

    def initialize(*)
      self.revision_source = REVISION_SOURCE
      super
    end

    def save
      revisions.unshift(new_revision)
      super
      revision_source.notify_save
    end

    def checkout(revision_id)
      return nil unless find_revision(revision_id)
      find_revision(revision_id).each do |field, value|
        send("#{field}=", value)
      end
      self
    end

    included do
      class_attribute :revision_fields
      self.revision_fields = []
      field :revisions, type: Array, default: []
    end

    class_methods do
      def revision_field(field)
        revision_fields << field
        self.field field
      end
    end

    private

    def new_revision
      revision_source.new_revision(self)
    end

    def find_revision(id)
      revisions.find { |revision| revision[:id] <= id }
    end
  end
end
