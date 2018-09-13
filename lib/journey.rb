class Journey
  attr_reader :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def end(station)
    @exit_station = station
  end

  def is_complete?
    exit_station != nil
  end

  def fare

  end

end
