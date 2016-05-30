require 'spec_helper'

describe Cooper::Document do
  context 'when included' do
    let(:klass) do
      Class.new do
        include Cooper::Document
      end
    end

    let(:revision_source) { double.as_null_object }

    let(:object) do
      klass.new.tap do |o|
        o.revision_source = revision_source
      end
    end

    it 'creates an array of revision_fields for the class' do
      expect(klass.revision_fields).to eq []
    end

    it 'includes Mongoid::Document' do
      expect(klass.included_modules).to include(Mongoid::Document)
    end

    describe '.revision_field' do
      it 'creates a getter instance method' do
        klass.revision_field :field
        expect(klass.new.public_methods).to include(:field)
      end

      it 'creates a setter instance method' do
        klass.revision_field :field
        expect(klass.new.public_methods).to include(:field=)
      end

      it 'creates a field for mongoid' do
        expect(klass).to receive(:field).with(:field, type: String)
        klass.revision_field(:field, type: String)
      end

      it 'adds the revisioned fields to the class list' do
        klass.revision_field :field
        expect(klass.revision_fields).to include(:field)
      end
    end

    describe '#revisions' do
      it 'is empty on initialization' do
        expect(klass.new.revisions).to be_empty
      end
    end

    describe '#save' do
      it 'calls save on Mongoid::Document' do
        expect_any_instance_of(Mongoid::Document).to receive(:save)
        object.save
      end

      context 'when mongoid is successful' do
        before do
          allow_any_instance_of(Mongoid::Document).to(
            receive(:save).and_return(true)
          )
        end

        it 'creates a new revision' do
          expect { object.save }.to change { object.revisions.size }.by(1)
        end

        it 'notifies the save to revision source' do
          expect(object.revision_source).to receive(:notify_save)
          object.save
        end
      end

      context 'when mongoid fails' do
        before do
          allow_any_instance_of(Mongoid::Document).to(
            receive(:save).and_return(false)
          )
        end

        it 'does not notify the save to the revision source' do
          expect(object.revision_source).not_to receive(:notify_save)
          object.save
        end

        it 'does not create a new revision' do
          expect { object.save }.not_to change { object.revisions }
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
        expect(object.checkout(time: Time.new(2015, 6)).key).to eq(2)
      end

      it 'checks out the appropriate revision by id' do
        expect(object.checkout(id: 3).key).to eq(2)
      end

      it 'returns nil if the object was not created yet' do
        expect(object.checkout(id: 1)).to be_nil
      end

      it 'fails if time and id are submitted' do
        expect {
          object.checkout(id: 2, time: Time.new(2016))
        }.to raise_error ArgumentError
      end
    end
  end
end
