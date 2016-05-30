describe Cooper::RevisionFinder do
  let(:clock) { Time }
  let(:document) { double }
  
  before do
    allow(document).to receive(:revisions).and_return(
      [
        { id: 7, key: 7, created_at: Time.new(2016, 4) },
        { id: 5, key: 5, created_at: Time.new(2016) },
        { id: 1, key: 1, created_at: Time.new(2015) }
      ]
    )
  end
  
  subject { Cooper::RevisionFinder.new(document) }
  
  describe '#find' do
    it 'raises an error when options does not include date or id' do
      expect { subject.find() }.to(
        raise_error ArgumentError
      )
    end

    it 'raises an error when both time and id options are used' do
      expect { subject.find(id: 1, time: clock.now) }.to(
        raise_error ArgumentError
      )
    end

    it 'removes the id field' do
      expect(subject.find(id: 1)[:id]).to be_nil
    end

    it 'removes the timestamp field' do
      expect(subject.find(id: 1)[:created_at]).to be_nil
    end

    it 'finds revision by id' do
      expect(subject.find(id: 3)[:key]).to eq 1
    end

    it 'finds revision by time' do
      expect(subject.find(time: Time.new(2016, 3))[:key]).to eq 5
    end
  end
end
