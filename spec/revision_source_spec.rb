describe Cooper::RevisionSource do
  let(:revision_source) { Cooper::RevisionSource.new }

  describe '#new_revision' do
    let(:object) { Object.new }

    before do
      allow(object.class).to receive(:revision_fields)
        .and_return([:field_1, :field_2])
      allow(object).to receive(:field_1).and_return(1)
      allow(object).to receive(:field_2).and_return(2)
    end

    it 'keeps track of the object revisioned fields' do
      revision = revision_source.new_revision(object)
      expect(revision[:field_1]).to eq 1
      expect(revision[:field_2]).to eq 2
    end

    it 'creates an id for the revision' do
      expect(revision_source.new_revision(object)[:id]).not_to be_nil
    end

    it 'creates a created_at field for the revision' do
      clock = Object.new
      allow(clock).to receive(:now).and_return(Time.new(2016))
      revision_source.clock = clock

      revision = revision_source.new_revision(object)

      expect(revision[:created_at]).to eq Time.new(2016)
    end
  end

  describe '#notify_save' do
    it 'increments revision_id by 1' do
      expect {
        revision_source.notify_save
      }.to change {
        revision_source.revision_id
      }.by(1)
    end
  end
end
