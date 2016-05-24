require 'spec_helper'

describe Cooper::Document do
  context 'when included' do
    let(:klass) do
      Class.new do
        include Cooper::Document
      end
    end

    it 'creates a list of revision_fields for the class' do
      expect(klass.revision_fields).to eq []
    end

    it 'includes Mongoid::Document as well' do
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
        mock(klass).field(:field)
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

    describe '#commit' do
      it 'creates a new revision' do
        object = klass.new
        expect { object.commit }.to change { object.revisions.size }.by(1)
      end
    end
  end
end
