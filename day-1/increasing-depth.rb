increasing_count = 0
previous_depth = -1

ARGF.each_line do |line|
  depth = line.to_i
  if previous_depth != -1 && depth > previous_depth
    increasing_count += 1
  end
  previous_depth = depth
end

puts "Depth increased #{increasing_count} times."