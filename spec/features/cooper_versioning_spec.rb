RSpec.describe 'cooper --version', type: :aruba do
  it 'displays information for cooper' do
    run_simple 'cooper --version'
    assert_matching_output(
      'Cooper \d+\.\d+\.\d+',
      output_from('cooper --version')
    )
  end
end
