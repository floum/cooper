# cooper document with one key example
class RevisionedObject
  include Cooper::Document

  revision_field :key, type: String
end

describe 'Saving documents' do
  let(:object) do
    RevisionedObject.new
  end
  it 'works like Mongoid::Document' do
    expect(object.save).to eq true
  end
end
