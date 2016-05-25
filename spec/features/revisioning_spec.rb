require 'support/mongoid_document'
require 'support/cooper_document'

describe 'Revisioning feature' do
  let(:revision_source) { Cooper::RevisionSource.new }

  describe 'Mongoid Configuration' do
    let(:object) { MongoidDocument.new }
    it 'is OK' do
      expect(object.save).to be_truthy
    end
  end

  describe 'Saving documents' do
    let(:object) do
      CooperDocument.new.tap { |doc| doc.revision_source = revision_source }
    end
    it 'is OK' do
      expect(object.save).to be_truthy
    end
  end

  describe 'Updating documents' do
    let(:object) do
      CooperDocument.new.tap { |doc| doc.revision_source = revision_source }
    end
    it 'works as expected' do
      object.key = 'value0'
      object.save
      object.update_attributes(key: 'value1')
      expect(object.key).to eq 'value1'
    end
  end

  describe 'Checking out documents' do
    let(:object) do
      CooperDocument.new.tap { |doc| doc.revision_source = revision_source }
    end
    it 'works as expected' do
      object.key = 'value0'
      object.save
      object.update_attributes(key: 'value1')
      object.update_attributes(key: 'value2')
      object.checkout(0)
      expect(object.key).to eq 'value0'
    end
  end
end
