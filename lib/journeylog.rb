require './lib/journey'

class JourneyLog
attr_reader :journeys, :current_journey

  def initialize(journey_class = Journey)
    @journeys = []
    @current_journey = nil
    @journey_class = journey_class
  end

  def start(station)
    current_journey
    @current_journey.start(station)
  end

  def finish(station)
    current_journey
    @current_journey.finish(station)
  end

  def complete_journey
    @journeys << @current_journey
    @current_journey = nil
  end

  def pay_fare
    @current_journey.pay_fare
    @current_journey.fare
  end

  private

  def current_journey
    @current_journey = (@current_journey ? @current_journey : @journey_class.new)
  end
end
