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
        expect(klass).to receive(:field).with(:field)
        klass.revision_field :field
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
      before do
        allow_any_instance_of(Mongoid::Document).to(
          receive(:save).and_return(true)
        )
      end

      it 'creates a new revision' do
        expect(object.revision_source).to receive(:new_revision)
        object.save
      end

      it 'calls save on Mongoid::Document' do
        expect_any_instance_of(Mongoid::Document).to receive(:save)
        object.save
      end

      context 'when successful' do
        it 'notifies the save to revision source' do
          expect(object.revision_source).to receive(:notify_save)
          object.save
        end
      end
    end

    describe '#checkout' do
      let(:revisions) { [{ id: 4, key: 4 }, { id: 2, key: 2 }] }

      before do
        klass.revision_field :key
        object.revisions = revisions
      end

      it 'checks out the appropriate revision' do
        expect(object.checkout(3).key).to eq(2)
      end

      it 'returns nil if the object was not created yet' do
        expect(object.checkout(1)).to be_nil
      end
    end
  end
end
