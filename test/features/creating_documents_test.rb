require 'test_helper'

describe 'Creating Documents' do
  # cooper document with one key example
  class RevisionedObject
    include Cooper::Document

    revision_field :key, type: String
  end

  subject { RevisionedObject.new }

  describe '#save' do
    it 'works as Mongoid::Document' do
      subject.save.must_equal true
    end
  end

  describe '.create' do
    it 'works as Mongoid::Document' do
      RevisionedObject.create(key: 'value').must_equal RevisionedObject.last
    end
  end
end
