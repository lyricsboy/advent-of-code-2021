class BingoBoard

  def initialize(string_board)
    @board_values = string_board.split("\n").map { |row| row.strip.split(/\s+/).map(&:to_i) }
    @board_number_positions = {}
    @board_values.each_with_index do |row, row_index|
      row.each_with_index do |value, column_index|
        @board_number_positions[value] = [row_index, column_index]
      end
    end
    @board_number_calls = @board_values.map {|row| row.map {|_| false }}
  end

  def size
    @board_values.size
  end

  def winner?
    # if any row is all called, that's a win
    return true if @board_number_calls.map {|row| row.all? }.any?
    # else if any column is all called, that's a win
    (0..size).map do |column| 
      (0..size).reduce(true) do |winner, row|
        winner && @board_number_calls[row][column]
      end
    end.any?
  end

  def value_at(row, column)
    @board_values[row][column]
  end

  def call_number(number)
    position = @board_number_positions[number]
    return if position.nil?
    @board_number_calls[position[0]][position[1]] = true
  end

  def sum_of_uncalled_numbers
    sum = 0
    @board_number_calls.each_with_index do |row, row_index|
      row.each_with_index do |called, column_index|
        sum += value_at(row_index, column_index) unless called
      end
    end
    sum
  end

end