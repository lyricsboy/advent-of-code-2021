require_relative "../line_overlap_counter"
require_relative "../line"

example_input = <<END
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
END

describe LineOverlapCounter do
  describe "adding lines" do

    it "does not add lines that are not vertical or horizontal" do
      counter = described_class.new(5,5)
      expect(counter.overlapping_point_count).to eq(0)
      counter.add_line(Line.parse("0,0 -> 0,4"))
      counter.add_line(Line.parse("0,0 -> 4,4"))
      expect(counter.overlapping_point_count).to eq(0)
    end

    it "counts a single overlapping point" do
      counter = described_class.new(5,5)
      expect(counter.overlapping_point_count).to eq(0)
      counter.add_line(Line.parse("0,0 -> 0,4"))
      counter.add_line(Line.parse("0,0 -> 4,0"))
      expect(counter.overlapping_point_count).to eq(1)
    end

    it "counts multiple overlapping points" do
      counter = described_class.new(5,5)
      expect(counter.overlapping_point_count).to eq(0)
      counter.add_line(Line.parse("0,0 -> 0,4"))
      counter.add_line(Line.parse("0,0 -> 0,4"))
      expect(counter.overlapping_point_count).to eq(5)
    end

    it "counts the example lines correctly" do
      example_lines = example_input.split("\n").map { |line| Line.parse(line) }
      max_x = example_lines.map(&:max_x).max
      max_y = example_lines.map(&:max_y).max
      counter = described_class.new(max_x + 1, max_y + 1)
      example_lines.each do |line|
        counter.add_line(line)
      end
      binding.pry
      expect(counter.overlapping_point_count).to eq(5)
    end

  end
end