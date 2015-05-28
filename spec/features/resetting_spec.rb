RSpec.describe 'cooper reset', type: :aruba do
  before :all do
    run_simple 'cooper update type:project name:cooper'
    run_simple 'cooper reset'
  end

  it 'resets the cooper item' do
    run_simple 'cooper read'
    expect(output_from('cooper read')).to eq("{}\n")
  end
end
