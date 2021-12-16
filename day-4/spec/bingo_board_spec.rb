require_relative "../bingo_board"

sample_board_1 = <<BOARD_1
22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19
BOARD_1

sample_board_2 = <<BOARD_2
3 15  0  2 22
9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6
BOARD_2

sample_board_3 = <<BOARD_3
14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
BOARD_3

input_values = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1".split(",").map(&:to_i)

describe BingoBoard do
  let(:sample_1) { BingoBoard.new(sample_board_1) }
  let(:sample_2) { BingoBoard.new(sample_board_2) }
  let(:sample_3) { BingoBoard.new(sample_board_3) }

  describe "construction and element access" do
    it "initializes from a sample board" do
      expect(sample_1.winner?).to be(false)
      expect(sample_1.size).to eq(5)
      expect(sample_1.value_at(0, 0)).to eq(22)
      expect(sample_1.value_at(0, 1)).to eq(13)
      expect(sample_1.value_at(4, 4)).to eq(19)
      expect(sample_1.value_at(4, 0)).to eq(1)
    end
  end

  describe "calling numbers" do

    it "is not a winner after calling some numbers" do
      input_values.take(11).each do |input|
        sample_1.call_number(input)
        sample_2.call_number(input)
        sample_3.call_number(input)
      end
      expect(sample_1.winner?).to eq(false)
      expect(sample_2.winner?).to eq(false)
      expect(sample_3.winner?).to eq(false)
    end

    it "is a winner after calling 5 in a row" do
      input_values.take(12).each do |input|
        sample_1.call_number(input)
        sample_2.call_number(input)
        sample_3.call_number(input)
      end
      expect(sample_1.winner?).to eq(false)
      expect(sample_2.winner?).to eq(false)
      expect(sample_3.winner?).to eq(true)
    end

  end

  describe "score" do
    it "matches the expected value after winning" do
      input_values.take(12).each do |input|
        sample_3.call_number(input)
      end
      expect(sample_3.winner?).to eq(true)
      expect(sample_3.sum_of_uncalled_numbers).to eq(188)
    end
  end
end