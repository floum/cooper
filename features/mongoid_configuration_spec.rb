describe 'Mongoid Configuration' do
  # Basic mongoid document example
  class MongoidObject
    include Mongoid::Document
  end

  let(:object) { MongoidObject.new }
  it 'is OK' do
    expect(object.save).to be_truthy
  end
end
