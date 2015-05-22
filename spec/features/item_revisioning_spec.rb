RSpec.describe 'Item revisioning', type: :aruba do
  it 'tracks the life of a single item' do
    run_simple 'cooper'
    assert_partial_output('{}', output_from('cooper'))
  end
end
