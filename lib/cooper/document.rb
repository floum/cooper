module Cooper
  # Mongoid Document compliant with Revisions
  module Document
    extend ActiveSupport::Concern
    include Mongoid::Document

    def revisions
      @revisions.dup
    end

    def initialize(*)
      @revisions = []
      super
    end

    def commit
      @revisions.push('r')
    end

    included do
      class_attribute :revision_fields
      self.revision_fields = []
    end

    class_methods do
      def revision_field(field)
        revision_fields << field
        self.field field
      end
    end
  end
end
