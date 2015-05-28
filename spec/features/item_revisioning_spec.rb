RSpec.describe 'Item revisioning', type: :aruba do
  before :all do
    `rm ~/.cooper_item`
    run_simple 'cooper update name:cooper version:0.0.0'
    run_simple 'cooper update author:floum location:unknown'
    run_simple 'cooper rm location'
    run_simple 'cooper update version:0.0.1'
  end
  it 'tracks the life of a single item' do
    run_simple 'cooper read'
    assert_partial_output(
      '{"name":"cooper",
        "version":"0.0.1",
        "author":"floum"}'.gsub(/\n\s+/, ''),
      output_from('cooper read'))
  end

  it 'ignores the deleted items' do
    run_simple 'cooper read --at 2'
    assert_partial_output(
      '{"name":"cooper",
        "version":"0.0.0",
        "author":"floum"}'.gsub(/\n\s+/, ''),
      output_from('cooper read --at 2'))
  end
end
