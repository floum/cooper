require 'test_helper'

describe Cooper::Document do
  describe 'when included' do
    let(:klass) do
      Class.new do
        include Cooper::Document
      end
    end

    let(:revision_source) { stub }

    let(:object) do
      klass.new.tap do |o|
        o.revision_source = revision_source
      end
    end

    it 'creates an array of revision_fields for the class' do
      klass.revision_fields.must_equal []
    end

    it 'includes Mongoid::Document' do
      klass.included_modules.must_include Mongoid::Document
    end

    describe '.revision_field' do
      it 'creates a getter instance method' do
        klass.revision_field :field
        klass.new.public_methods.must_include :field
      end

      it 'creates a setter instance method' do
        klass.revision_field :field
        klass.new.public_methods.must_include :field=
      end

      it 'creates a field for mongoid' do
        stub(klass).field(:field, type: String)
        # klass.revision_field(:field, type: String)
      end

      it 'adds the revisioned fields to the class list' do
        klass.revision_field :field
        klass.revision_fields.must_include :field
      end
    end

    describe '#revisions' do
      it 'is empty on initialization' do
        klass.new.revisions.must_be_empty
      end
    end

    describe '#save' do
      describe 'when valid' do
        before do
          stub(Mongoid::Document).valid? { true }
          stub(Mongoid::Document).save { true }
        end

        it 'calls save on Mongoid::Document' do
          skip
          object.save
        end

        it 'creates a new revision' do
          revision_count = object.revisions.count
          object.save
          object.revisions_count.must_equal(revision_count + 1)
        end

        it 'notifies the save to revision source' do
          stub(revision_source).new_revision(object)
          object.save.must_send :notify_save, revision_source
        end
      end

      describe 'when invalid' do
        before do
          stub(object).valid? { false }
        end

        it 'does not notify the save to the revision source' do
          skip
          object.save
        end

        it 'does not create a new revision' do
          revision_count = object.revisions.count
          object.save
          object.revisions.count.must_equal(revision_count)
        end
      end
    end

    describe '#checkout' do
      let(:revisions) {
        [
          { created_at: Time.new(2016), id: 4, key: 4 },
          { created_at: Time.new(2015), id: 2, key: 2 }
        ]
      }

      before do
        klass.revision_field :key
        object.revisions = revisions
      end

      it 'checks out the appropriate revision by date' do
        object.checkout(time: Time.new(2015, 6)).key.must_equal 2
      end

      it 'checks out the appropriate revision by id' do
        object.checkout(id: 3).key.must_equal 2
      end

      it 'returns nil if the object was not created yet' do
        object.checkout(id: 1).must_be_nil
      end

      it 'fails if time and id are submitted' do
        -> { object.checkout(id: 2, time: Time.new(2016)) }.must_raise ArgumentError
      end
    end
  end
end
