require_relative "lanternfish_breeder"

fish_ages = ARGF.read.split(",").map(&:to_i)

breeder = LanternfishBreeder.new(fish_ages)
80.times { breeder.breed }
puts "After 80 days, there are #{breeder.fish_ages.count} fish."