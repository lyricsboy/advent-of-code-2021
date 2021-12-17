require_relative "line_overlap_counter"
require_relative "line"

lines = ARGF.each_line.map do |input_line|
  Line.parse(input_line)
end

max_x = lines.map(&:max_x).max
max_y = lines.map(&:max_y).max
counter = LineOverlapCounter.new(max_x + 1, max_y + 1)
lines.each do |line|
  counter.add_line(line)
end

puts "From these #{lines.size} lines, I have counted #{counter.overlapping_point_count} overlapping points."