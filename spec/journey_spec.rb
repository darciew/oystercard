require 'journey'

describe Journey do
  subject(:journey) { described_class.new("Waterloo") }

  it 'checks if a journey is completed' do
    expect(subject.is_complete?).to eq false
  end
end
