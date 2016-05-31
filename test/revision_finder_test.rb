require 'test_helper'

describe Cooper::RevisionFinder do
  let(:clock) { Time }
  let(:document) { stub }
  
  before do
    stub(document).revisions {
      [
        { id: 7, key: 7, created_at: Time.new(2016, 4) },
        { id: 5, key: 5, created_at: Time.new(2016) },
        { id: 1, key: 1, created_at: Time.new(2015) }
      ]
    }
  end
  
  subject { Cooper::RevisionFinder.new(document) }
  
  describe '#find' do
    it 'raises an error when options does not include date or id' do
      -> { subject.find() }.must_raise ArgumentError
    end

    it 'raises an error when both time and id options are used' do
      -> { subject.find(id: 1, time: clock.now) }.must_raise ArgumentError
    end

    it 'removes the id field' do
      subject.find(id: 1)[:id].must_equal nil
    end

    it 'removes the timestamp field' do
      subject.find(id: 1)[:created_at].must_equal nil
    end

    it 'finds revision by id' do
      subject.find(id: 3)[:key].must_equal 1
    end

    it 'finds revision by time' do
      subject.find(time: Time.new(2016, 3))[:key].must_equal 5
    end
  end
end
