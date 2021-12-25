require_relative "display_counter"

counters = ARGF.each_line.to_a.map {|line| DisplayCounter.new(line) }

decoded_output_values = counters.map(&:decoded_output_value)
total_output = decoded_output_values.sum
puts "Total output value: #{total_output}"