require_relative 'binary_number_reader'

READING_SIZE = 12

readings = BinaryNumberReader.new(ARGF).to_a

def determine_rating(readings:, find_most_commmon:)
  remaining_readings = readings.dup
  comparator = find_most_commmon ? :">=" : :"<"
  (READING_SIZE - 1).downto(0).each do |i|
    bit_test = 1 << i
    readings_with_bit_set = []
    readings_without_bit_set = []
    remaining_readings.each do |reading|
      if reading & bit_test == bit_test
        readings_with_bit_set << reading
      else 
        readings_without_bit_set << reading
      end
    end
    if readings_with_bit_set.size.send(comparator, readings_without_bit_set.size)
      remaining_readings = readings_with_bit_set
    else
      remaining_readings = readings_without_bit_set
    end
    break if remaining_readings.size == 1
  end
  remaining_readings
end

o2_rating = determine_rating(readings: readings, find_most_commmon: true)
co2_rating = determine_rating(readings: readings, find_most_commmon: false)

puts "O2 rating: #{o2_rating}"
puts "CO2 rating: #{co2_rating}"
puts "Life Support rating: #{o2_rating.first * co2_rating.first}"