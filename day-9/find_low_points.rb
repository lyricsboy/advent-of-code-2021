require_relative "height_map"

height_map = HeightMap.new(ARGF.read)

low_point_values = height_map.low_point_values

risk_levels = low_point_values.map { |value| value + 1 }

puts "Total risk level: #{risk_levels.sum}"