class FuelCalculator

  def initialize(horizontal_positions)
    @horizontal_positions = horizontal_positions
  end

  def minimum_fuel_requirements
    sorted_positions = @horizontal_positions.sort
    median = if sorted_positions.size.even?
      middle = sorted_positions.size / 2
      (sorted_positions[middle - 1] + sorted_positions[middle]) / 2
    else
      middle = (sorted_positions.size + 1) / 2
      sorted_positions[middle - 1]
    end
    sorted_positions.reduce(0) { |distance_from_median, position| distance_from_median + (position - median).abs }
  end
end