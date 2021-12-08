require_relative 'binary_number_reader'

total_readings = 0
READING_SIZE = 12
reading_bitwise_sums = Array.new(READING_SIZE, 0)

BinaryNumberReader.new(ARGF).each do |reading|
  total_readings += 1
  READING_SIZE.times do |i|
    is_bit_set = ((1 << i) & reading) > 0 ? 1 : 0
    reading_bitwise_sums[i] += is_bit_set
  end
end
# these bits are now in reverse order, let's fix that
reading_bitwise_sums.reverse!

puts "Total readings: #{total_readings}"

gamma_values = reading_bitwise_sums.map { |value| (value >= total_readings / 2) ? 1 : 0 }
# this is basically bitwise NOT of gamma
epsilon_values = reading_bitwise_sums.map { |value| (value < total_readings / 2) ? 1 : 0 }

gamma = gamma_values.each_with_index.to_a.map { |value_and_index| value_and_index[0] << READING_SIZE - 1 - value_and_index[1] }.reduce(:+)
epsilon = epsilon_values.each_with_index.to_a.map { |value_and_index| value_and_index[0] << READING_SIZE - 1 - value_and_index[1] }.reduce(:+)
puts "Gamma: #{gamma_values.map(&:to_s).join('')} (#{gamma})"
puts "Epsilon: #{epsilon_values.map(&:to_s).join('')} (#{epsilon})"

puts "Power consumption: #{gamma * epsilon}"