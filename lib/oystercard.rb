require './lib/journeylog'

class Oystercard
  attr_reader :balance, :journeys, :current_trip, :journey_class

  BALANCE_CAP = 90
  MINIMUM_FARE = 1

  def initialize(journey_log = JourneyLog)
    @balance = 0
    @journey_log = journey_log.new
    @current_trip = nil
  end

  def top_up(amount)
    raise "Top-up can't exceed card limit of £#{BALANCE_CAP}" if exceed_balance_cap?(amount)
    @balance += amount
  end

  def touch_in(station)
    pay_fare if @current_trip != nil
    raise "Insufficient funds!" if insufficient_funds?
    @current_trip = @journey_log.start(station)
  end

  def touch_out(station)
    @current_trip = @journey_log.finish(station)
    pay_fare
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

  def pay_fare
    deduct @journey_log.pay_fare
    @journey_log.complete_journey
    @current_trip = nil
  end

end
