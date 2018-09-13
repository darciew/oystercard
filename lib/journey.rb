class Journey
  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
    @fare = 0
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def is_complete?
    (@entry_station != nil) && (@exit_station != nil)
  end

  def in_journey?
    @entry_station != nil
  end

  def pay_fare
    @fare = fare
  end

  def fare
    return MINIMUM_FARE + distance if is_complete?
    return PENALTY_FARE if (@entry_station != nil) || (@exit_station != nil)
    return 0
  end

  def minimum_fare
    MINIMUM_FARE
  end

  def distance
    (@entry_station.zone - @exit_station.zone).abs
  end

end
