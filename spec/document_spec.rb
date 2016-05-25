require 'spec_helper'

describe Cooper::Document do
  context 'when included' do
    let(:klass) do
      Class.new do
        include Cooper::Document
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
        object = klass.new
        expect(object).to receive(:new_revision)
        object.save
      end

      it 'calls save on Mongoid::Document' do
        expect_any_instance_of(Mongoid::Document).to receive(:save)
        object = klass.new
        object.save
      end
    end

    describe '#new_revision' do
      it 'calls new_revision on revision_source' do
        skip
      end
    end
  end
end
