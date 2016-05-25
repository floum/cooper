module Cooper
  # Mongoid Document compliant with Revisions
  module Document
    extend ActiveSupport::Concern
    include Mongoid::Document

    def save
      revisions.push(new_revision)
      super
    end

    def new_revision
    end

    included do
      class_attribute :revision_fields
      self.revision_fields = []
      field :revisions, type: Array, default: []
    end

    class_methods do
      def revision_source
        object = Object.new
        object.define_singleton_method(:new_revision) do |_|
        end
        object
      end

      def revision_field(field)
        revision_fields << field
        self.field field
      end
    end
  end
end
