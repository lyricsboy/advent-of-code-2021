require "matrix"

class HeightMap
    attr_reader :size

    def initialize(string_representation)
        @matrix = Matrix.rows(string_representation.split("\n").map { |line| line.chars.to_a.map(&:to_i) })
        @size = [@matrix.column_count, @matrix.row_count]
    end

    def low_points
        low_points = []
        @matrix.row_count.times do |row_index|
            @matrix.column_count.times do |column_index|
                value = @matrix[row_index, column_index]
                neighbors = [
                    [row_index -1, column_index],
                    [row_index, column_index - 1],
                    [row_index, column_index + 1],
                    [row_index + 1, column_index]
                ]
                is_local_minimum = neighbors.reduce(true) do |is_minimum, neighbor|
                    if neighbor[0] < 0 || neighbor[0] >= @matrix.row_count || neighbor[1] < 0 || neighbor[1] >= @matrix.column_count
                        next is_minimum
                    end
                    is_minimum && value < @matrix[neighbor[0], neighbor[1]]
                end
                low_points << [row_index, column_index] if is_local_minimum
            end
        end
        low_points
    end

    def low_point_values
        low_points.map { |point| @matrix[point[0], point[1]] }
    end

    def basin_sizes
        low_points.map do |low_point|
            basin_points(low_point).size
        end
    end

    def basin_points(point)
        ([point] + basin_neighbor_points(point).map { |neighbor| basin_points(neighbor) }.flatten(1)).uniq
    end

    def basin_neighbor_points(point)
        point_value = @matrix[point[0], point[1]]
        neighbors = [
            [point[0] -1, point[1]],
            [point[0], point[1] - 1],
            [point[0], point[1] + 1],
            [point[0] + 1, point[1]]
        ]
        neighbors.filter do |neighbor|
            if neighbor[0] < 0 || neighbor[0] >= @matrix.row_count || neighbor[1] < 0 || neighbor[1] >= @matrix.column_count
                next false
            end
            neighbor_value = @matrix[neighbor[0], neighbor[1]]
            neighbor_value > point_value && neighbor_value < 9
        end
    end
end