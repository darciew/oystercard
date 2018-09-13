class Oystercard
  attr_reader :balance, :journeys, :current_journey


  BALANCE_CAP = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @journeys = []
    @journey_class = journey_class
  end

  def top_up(amount)
    raise "Top-up can't exceed card limit of £#{BALANCE_CAP}" if exceed_balance_cap?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds!" if insufficient_funds?
    @current_journey = @journey_class.new(station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @current_journey.end(exit_station)
    @journeys << @current_journey
    @current_journey = nil
  end

  def in_journey?
    @current_journey != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_balance_cap?(amount)
    @balance + amount > BALANCE_CAP
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

end
