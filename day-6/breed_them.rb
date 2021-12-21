require_relative "lanternfish_breeder"

fish_ages = ARGF.read.split(",").map(&:to_i)

breeder = LanternfishBreeder.new(fish_ages)
256.times { breeder.breed }
puts "After 256 days, there are #{breeder.fish_count} fish."