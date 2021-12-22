require_relative "fuel_calculator"

positions = ARGF.read.split(",").map(&:to_i)

calculator = FuelCalculator.new(positions)

fuel = calculator.minimum_fuel_requirements

puts "Minimum fuel requirements: #{fuel}"