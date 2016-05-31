require 'features_helper'

describe 'Validations' do
  # basic cooper document validations example
  class ValidatedObject
    include Cooper::Document

    revision_field :single_digit, type: Integer

    validates :single_digit, inclusion: { in: (0..9) }
  end

  it 'works just like Mongoid::Document' do
    object = ValidatedObject.new(single_digit: 5)
    object.save.must_equal true

    object = ValidatedObject.new(single_digit: 10)
    object.save.must_equal false
  end
end
