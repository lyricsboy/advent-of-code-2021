sliding_window_size = 3
increasing_count = 0
previous_depth_sum = -1

sliding_window = []

ARGF.each_line do |line|
  depth = line.to_i
  sliding_window << depth
  if sliding_window.size > sliding_window_size
    sliding_window.shift
  end
  next unless sliding_window.size == sliding_window_size
  depth_sum = sliding_window.reduce(:+)
  puts depth_sum
  if previous_depth_sum != -1 && depth_sum > previous_depth_sum
    increasing_count += 1
  end
  previous_depth_sum = depth_sum
end

puts "Depth increased #{increasing_count} times."