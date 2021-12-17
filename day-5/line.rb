class Line
  attr_reader :origin_point, :destination_point

  def self.parse(input_line)
    origin_input, destination_input = input_line.split(/\s+\-\>\s+/)
    origin = Point.parse(origin_input)
    destination = Point.parse(destination_input)
    new(origin, destination)
  end

  def initialize(origin_point, destination_point)
    @origin_point = origin_point
    @destination_point = destination_point
    unless vertical? || horizontal? || forty_five_degrees?
      raise ArgumentError, "Invalid points: #{origin_point} -> #{destination_point}"
    end
  end

  def vertical?
    @origin_point.x == @destination_point.x
  end

  def horizontal?
    @origin_point.y == @destination_point.y
  end

  def forty_five_degrees?
    (@destination_point.y - @origin_point.y).abs == (@destination_point.x - @origin_point.x).abs
  end

  def x_range
    if @origin_point.x < @destination_point.x
      (@origin_point.x)..(@destination_point.x)
    else
      (@destination_point.x)..(@origin_point.x)
    end
  end

  def y_range
    if @origin_point.y < @destination_point.y
      (@origin_point.y)..(@destination_point.y)
    else
      (@destination_point.y)..(@origin_point.y)
    end
  end

  def points
    x_increment = @destination_point.x <=> @origin_point.x
    y_increment = @destination_point.y <=> @origin_point.y
    num_points = [x_range.size, y_range.size].max
    0.upto(num_points - 1).map do |i|
      Point.new(@origin_point.x + i * x_increment, @origin_point.y + i * y_increment)
    end
  end

  def max_x
    [@origin_point.x, @destination_point.x].max
  end

  def max_y
    [@origin_point.y, @destination_point.y].max
  end

end

Point = Struct.new(:x, :y) do
  def self.parse(input)
    x, y = input.split(",").map(&:to_i)
    new(x, y)
  end
end