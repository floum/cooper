describe Cooper::RevisionSource do
  let(:revision_source) { Cooper::RevisionSource.new }

  describe '#new_revision' do
    let(:object) { double }

    it 'keeps track of the object revisioned fields' do
      allow(object).to receive(:revision_fields)
        .and_return([:field_1, :field_2])
      allow(object).to receive(:field_1).and_return(1)
      allow(object).to receive(:field_2).and_return(2)

      revision = revision_source.new_revision(object)
      expect(revision.field_1).to eq 1
      expect(revision.field_2).to eq 2
    end
  end
end
