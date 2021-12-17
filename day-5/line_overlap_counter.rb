require 'matrix'

class LineOverlapCounter

  def initialize(size_x, size_y)
    @matrix = Matrix.zero(size_x, size_y)
  end

  def add_line(line)
    if line.vertical?
      line.y_range.each do |y|
        @matrix[line.origin_point.x, y] = @matrix[line.origin_point.x, y] + 1
      end
    elsif line.horizontal?
      line.x_range.each do |x|
        @matrix[x, line.origin_point.y] = @matrix[x, line.origin_point.y] + 1
      end
    end
  end

  def overlapping_point_count
    @matrix.each.filter {|i| i > 1}.size
  end

end