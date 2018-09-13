require 'oystercard'
describe Oystercard do
  let(:station) { double :station }
  let(:station2) { double :station2 }

  describe 'Initialise' do
    it 'has balance of 0 when initialised' do
      expect(subject::balance).to eq 0
    end

    it 'has no journeys recorded when initialised' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#top_up' do
    it 'increases the balance by top up amount' do
      subject.top_up(5)
      expect(subject::balance).to be 5
    end

    it 'raises error when top_up would make balance over the balance cap' do
      expect{subject.top_up(Oystercard::BALANCE_CAP + 1)}.to raise_error(
        "Top-up can't exceed card limit of £#{Oystercard::BALANCE_CAP}")
    end
  end

  describe '#touch_in' do
    context 'has enough funds for minimum fare' do
      before(:each) do
        subject.top_up(Oystercard::MINIMUM_FARE)
        subject.touch_in(station)
      end
      it 'starts a journey' do
        expect(subject).to be_in_journey
      end

      it 'remembers the entry station' do
        station_name = "Aldgate East"
        allow(station).to receive(:name) {station_name}
        expect(subject.current_journey.entry_station.name).to eq station_name
      end
    end

    context 'has no funds' do
      it 'raises error if balance below minimum fare' do
        expect{subject.touch_in(station)}.to raise_error("Insufficient funds!")
      end
    end

  end

  describe '#touch_out' do
    before(:each) do
      @fare = Oystercard::MINIMUM_FARE
      subject.top_up(@fare)
      subject.touch_in(station)
    end

    it 'ends a journey' do
      subject.touch_out(station2)
      expect(subject).not_to be_in_journey
    end
    it 'charges minimum fare' do
      expect{ subject.touch_out(station2) }.to change{ subject.balance }.by(-@fare)
    end

    it 'forgets the entry station' do
      expect{ subject.touch_out(station2) }.to change{ subject.current_journey }.to be_nil
    end

    it 'creates a journey' do
      subject.touch_out(station2)
      expect(subject.journeys).to include{subject.journey}
      #expect(subject.journeys).to include {sation1 and station2}
      end
    end
  end
end
