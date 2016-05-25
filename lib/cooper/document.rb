module Cooper
  # Mongoid Document compliant with Revisions
  module Document
    extend ActiveSupport::Concern
    include Mongoid::Document

    attr_accessor :revision_source

    def initialize(*)
      super
    end

    def save
      revisions.push(new_revision)
      super
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
  end
end
