describe Cooper::RevisionSource do
  let(:revision_source) { Cooper::RevisionSource.new }

  describe '#new_revision' do
    let(:object) { Object.new }

    before do
      stub(object.class).revision_fields { [:field_1, :field_2] }
      stub(object).field_1 { 1 }
      stub(object).field_2 { 2 }
    end

    it 'keeps track of the object revisioned fields' do
      revision = revision_source.new_revision(object)
      revision[:field_1].must_equal 1
      revision[:field_2].must_equal 2
    end

    it 'creates an id for the revision' do
      revision_source.new_revision(object)[:id].wont_equal nil
    end

    it 'creates a created_at field for the revision' do
      clock = Object.new
      stub(clock).now { Time.new(2016) }
      revision_source.clock = clock

      revision = revision_source.new_revision(object)

      revision[:created_at].must_equal Time.new(2016)
    end
  end

  describe '#notify_save' do
    it 'increments revision_id by 1' do
      initial_id = revision_source.revision_id
      revision_source.notify_save
      revision_source.revision_id.must_equal(initial_id + 1)
    end
  end
end
