require_relative "display_counter"

counters = ARGF.each_line.to_a.map {|line| DisplayCounter.new(line) }

decoded_output_values = counters.map(&:decoded_output_values)
known_values = [1,4,7,8]
known_value_count = decoded_output_values.reduce(0) do |sum, values|
    sum += values.filter { |value| known_values.include?(value) }.count
end

puts "Found #{known_value_count} known values"