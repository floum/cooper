# cooper document with one key example
class RevisionedObject
  include Cooper::Document

  revision_field :key, type: String
end

describe 'Updating documents' do
  let(:object) do
    RevisionedObject.new
  end
  it 'works like Mongoid::Document' do
    object.key = 'value0'
    object.save
    object.update_attributes(key: 'value1')
    expect(object.key).to eq 'value1'
  end
end
