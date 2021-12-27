require "matrix"

class HeightMap
    attr_reader :size

    def initialize(string_representation)
        @matrix = Matrix.rows(string_representation.split("\n").map { |line| line.chars.to_a.map(&:to_i) })
        @size = [@matrix.column_count, @matrix.row_count]
    end

    def low_point_values
        low_point_values = []
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
                low_point_values << value if is_local_minimum
            end
        end
        low_point_values
    end
end