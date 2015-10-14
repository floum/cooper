RSpec.describe 'Item revisioning', type: :aruba do
  before :all do
    run_simple 'cooper reset'
    run_simple 'cooper update name:cooper version:0.0.0'
    run_simple 'cooper update author:floum location:unknown'
    run_simple 'cooper rm location'
    run_simple 'cooper update version:0.0.1'
  end

  it 'tracks the life of a single item' do
    run_simple 'cooper read'
    expect(stdout_from('cooper read')).to match('{"name":"cooper",
        "version":"0.0.1",
        "author":"floum"}'.gsub(/\n\s+/, ''))
  end

  it 'ignores the deleted items' do
    run_simple 'cooper read --at 2'
    expect(stdout_from('cooper read --at 2')).to match(
      '{"name":"cooper",
        "version":"0.0.0",
        "author":"floum"}'.gsub(/\n\s+/, ''))
  end
end
