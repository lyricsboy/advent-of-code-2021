require_relative "bingo_board"

input_numbers_file, input_boards_file = ARGV

input_numbers = IO.read(input_numbers_file).split(",").map(&:to_i)

input_boards = IO.read(input_boards_file).split("\n\n").map { |board| BingoBoard.new(board) }

winning_number = -1
winning_boards = []
input_numbers.take_while do |number|
  puts "Calling #{number}"
  input_boards.each do |board|
    board.call_number(number)
  end
  new_winning_boards, remaining_input_boards = input_boards.partition { |b| b.winner? }
  winning_number = number if new_winning_boards.size > 0
  winning_boards.concat(new_winning_boards)
  input_boards = remaining_input_boards
  input_boards.size > 0
end
winning_board = winning_boards.last

puts "Winning number: #{winning_number}"
puts "Winning board uncalled numbers sum: #{winning_board.sum_of_uncalled_numbers}"
puts "Winning score: #{winning_number * winning_board.sum_of_uncalled_numbers}"