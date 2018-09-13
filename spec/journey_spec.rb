require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  it 'checks if a journey is completed' do
    expect(subject.is_complete?).to eq false
  end

  it 'enters and leaves and should pay minimum fare' do
    subject.enter("Aldgate")
    subject.leave("Aldgate East")
    expect(subject.fare).to eq described_class::MINIMUM_FARE
  end

  it 'enters and leaves and should pay minimum fare' do
    subject.leave("Aldgate East")
    expect(subject.fare).to eq described_class::PENALTY_FARE
  end

  it 'does not charge the card if no journey is made' do
    expect(subject.fare).to eq 0
  end

end
