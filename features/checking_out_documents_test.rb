require 'features_helper'

describe 'Checking Out Documents' do
  # cooper document with one key example
  class RevisionedObject
    include Cooper::Document

    revision_field :key, type: String
  end

  subject { RevisionedObject.new }

  let(:clock) { Object.new }

  it 'manages multiple objects' do
    o1 = RevisionedObject.create(key: '1.1')
    o2 = RevisionedObject.create(key: '2.2')
    o1.update_attributes(key: '1.3')
    o2.update_attributes(key: '2.4')
    o1.update_attributes(key: '1.5')
    o1.update_attributes(key: '1.6')
    o2.update_attributes(key: '2.7')
    o1.checkout(id: 4).key.must_equal '1.3'
    o2.checkout(id: 4).key.must_equal '2.4'
    o1.checkout(time: Time.now).key.must_equal '1.6'
    o2.checkout(time: Time.now).key.must_equal '2.7'
  end

  it 'is possible by id' do
    subject.key = 'value1'
    subject.save
    subject.update_attributes(key: 'value2')
    subject.checkout(id: 1).key.must_equal 'value1'
  end

  it 'is possible by time' do
    stub(clock).now { Time.new(2015) }
    Cooper::REVISION_SOURCE.clock = clock

    object = RevisionedObject.new
    object.key = 'value_2015'
    object.save

    stub(clock).now { Time.new(2016) }
    object.update_attributes(key: 'value_2016')

    object.checkout(time: Time.new(2015, 4)).key.must_equal 'value_2015'
    object.checkout(time: Time.new(2016,2)).key.must_equal 'value_2016'
  end
end
