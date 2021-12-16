require_relative "bingo_board"

input_numbers_file, input_boards_file = ARGV

input_numbers = IO.read(input_numbers_file).split(",").map(&:to_i)

input_boards = IO.read(input_boards_file).split("\n\n").map { |board| BingoBoard.new(board) }

we_have_a_winner = false
winning_number = -1
winning_board = nil
input_numbers.take_while do |number|
  puts "Calling #{number}"
  input_boards.each do |board|
    board.call_number(number)
    if board.winner?
      puts "We have a winner!"
      we_have_a_winner = true
      winning_board = board
      winning_number = number
      break
    end
  end
  !we_have_a_winner
end

puts "Winning number: #{winning_number}"
puts "Winning board uncalled numbers sum: #{winning_board.sum_of_uncalled_numbers}"
puts "Winning score: #{winning_number * winning_board.sum_of_uncalled_numbers}"