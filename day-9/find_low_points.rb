require_relative "height_map"

height_map = HeightMap.new(ARGF.read)

low_point_values = height_map.low_point_values

risk_levels = low_point_values.map { |value| value + 1 }

puts "Total risk level: #{risk_levels.sum}"

basin_sizes = height_map.basin_sizes.sort.reverse

puts "All basin sizes: #{basin_sizes}"

first_three = basin_sizes[0...3]
multiplied = first_three.reduce(&:*)

puts "First three #{first_three} multiplied: #{multiplied}"