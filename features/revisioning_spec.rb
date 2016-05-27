describe 'Revisioning feature' do
  # cooper document with one key example
  class RevisionedObject
    include Cooper::Document

    revision_field :key
  end

  describe 'Saving documents' do
    let(:object) do
      RevisionedObject.new
    end
    it 'is OK' do
      expect(object.save).to be_truthy
    end
  end

  describe 'Updating documents' do
    let(:object) do
      RevisionedObject.new
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
      RevisionedObject.new
    end
    it 'works as expected' do
      object.key = 'value1'
      object.save
      object.update_attributes(key: 'value2')
      object.update_attributes(key: 'value3')
      object.checkout 1
      expect(object.key).to eq 'value1'
      object.checkout 3
      expect(object.key).to eq 'value3'
    end
    it 'manages multiple objects' do
      object_1 = RevisionedObject.new
      object_1.key = '1.1'
      object_1.save
      object.save
      object.key = '1.2'
      object_2 = RevisionedObject.new
      object_2.key = '2.3'
      object_2.save
      object_1.key = '1.4'
      object_1.save
      object_2.key = '2.5'
      object_2.save
      object_1.key = '1.6'
      object_1.save
      object_1.checkout 4
      expect(object_1.key).to eq '1.4'
      object_2.checkout 4
      expect(object_2.key).to eq '2.3'
    end
  end
end
