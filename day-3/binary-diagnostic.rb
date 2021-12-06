total_readings = 0
READING_SIZE = 12
reading_bitwise_sums = Array.new(READING_SIZE, 0)

ARGF.each_line do |line|
  total_readings += 1
  READING_SIZE.times do |i|
    reading_bitwise_sums[i] += line[i].to_i
  end
end

gamma_values = reading_bitwise_sums.map { |value| (value >= total_readings / 2) ? '1' : '0' }
# this is basically logical NOT of gamma
epsilon_values = reading_bitwise_sums.map { |value| (value < total_readings / 2) ? '1' : '0' }

gamma = gamma_values.map(&:to_i).each_with_index.to_a.map { |value_and_index| value_and_index[0] << READING_SIZE - 1 - value_and_index[1] }.reduce(:+)
epsilon = epsilon_values.map(&:to_i).each_with_index.to_a.map { |value_and_index| value_and_index[0] << READING_SIZE - 1 - value_and_index[1] }.reduce(:+)
puts "Gamma: #{gamma_values.join('')} (#{gamma})"
puts "Epsilon: #{epsilon_values.join('')} (#{epsilon})"

puts "Power consumption: #{gamma * epsilon}"