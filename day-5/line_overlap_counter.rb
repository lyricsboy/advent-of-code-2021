require 'matrix'

class LineOverlapCounter

  def initialize(size_x, size_y)
    @matrix = Matrix.zero(size_x, size_y)
  end

  def add_line(line)
    line.points.each do |point|
      @matrix[point.x, point.y] = @matrix[point.x, point.y] + 1
    end
  end

  def overlapping_point_count
    @matrix.each.filter {|i| i > 1}.size
  end

end