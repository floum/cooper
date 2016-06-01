describe 'Validations' do
  # basic cooper document validations example
  class ValidatedObject
    include Cooper::Document

    revision_field :single_digit, type: Integer

    validates :single_digit, inclusion: { in: (0..9) }
  end

  it 'work like Mongoid::Document' do
    object = ValidatedObject.new(single_digit: 5)
    expect(object.save).to be_truthy

    object = ValidatedObject.new(single_digit: 10)
    expect(object.save).not_to be_truthy
  end
end
