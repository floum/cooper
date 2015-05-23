RSpec.describe 'Item revisioning', type: :aruba do
  it 'tracks the life of a single item' do
    run_simple 'cooper update name:cooper version:0.0.0'
    run_simple 'cooper update author:unknown location:unknown'
    run_simple 'cooper update author:floum version:0.0.1'
    run_simple 'cooper read'
    assert_partial_output(
      '{
"name":"cooper",
"version":"0.0.1",
"author":"floum",
"location":"unknown"
}'.gsub("\n", ''),
      output_from('cooper read'))
  end
end
