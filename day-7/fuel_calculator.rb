class FuelCalculator

  def initialize(horizontal_positions)
    @horizontal_positions = horizontal_positions
  end

  def minimum_fuel_requirements
    mean = @horizontal_positions.sum / Float(@horizontal_positions.size)
    mean_floor = mean.floor
    mean_ceil = mean.ceil
    [calculate_fuel_from(mean_floor), calculate_fuel_from(mean_ceil)].min
  end

  private

  def calculate_fuel_from(mean)
    @horizontal_positions.reduce(0) do |distance_from_mean, position|
      distance_from_mean + (position - mean).abs.downto(1).sum
    end
  end
end