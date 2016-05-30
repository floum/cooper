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
      if valid?
        revisions.unshift(new_revision)
        begin
          super(validate: false)
        rescue MongoidError => e
          revisions.shift
          raise e
        end
        revision_source.notify_save
      end
    end

    def checkout(options = {})
      return nil unless find_revision(options)

      find_revision(options)
        .each do |field, value|
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
      def revision_field(field, options = {})
        revision_fields << field
        self.field field, options
      end
    end

    private

    def new_revision
      revision_source.new_revision(self)
    end

    def find_revision(options)
      RevisionFinder.new(self).find(options)
    end
  end
end
