require 'support/mongoid_document'
require 'support/cooper_document'

describe 'Revisioning feature' do
  describe 'Mongoid Configuration' do
    let(:object) { MongoidDocument.new }
    it 'is OK' do
      expect(object.save).to be_truthy
    end
  end

  describe 'Cooper Configuration' do
    let(:object) do
      CooperDocument.new.tap { |doc| doc.revision_source = Cooper::RevisionSource.new }
    end
    it 'is OK' do
      expect(object.save).to be_truthy
    end
  end
end
