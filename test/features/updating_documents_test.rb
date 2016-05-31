require 'test_helper'

describe 'Updating Documents' do
  # cooper document with one key example
  class RevisionedObject
    include Cooper::Document

    revision_field :key, type: String
  end

  subject { RevisionedObject.create(key: 'not_a_value') }

  it 'works like Mongoid::Document' do
    subject.update_attributes(key: 'value').must_equal true
    subject.key.must_equal 'value'
  end
end
