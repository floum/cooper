describe 'Validations' do
  # basic cooper document validations example
  class ValidatedObject
    include Cooper::Document

    revision_field :single_digit, type: Integer

    validates :single_digit, inclusion: { in: (0..9) }
  end

  it 'work like Mongoid::Document' do
    object = ValidatedObject.new(single_digit: 5)
    expect(object.save).to eq true

    object = ValidatedObject.new(single_digit: 10)
    expect(object.save).to eq false
  end

  it 'can be bypassed with validate: false' do
    object = ValidatedObject.new(single_digit: 10)
    expect(object.save(validate: false)).to eq true
  end
end
