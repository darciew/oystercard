require 'station'

describe Station do
  let(:waterloo) {Station.new("Waterloo", 1)}
  it 'exposes a name variable' do
    expect(waterloo.name).to eq "Waterloo"
  end
  it 'exposes a zone variable' do
    expect(waterloo.zone).to eq 1
  end

end
