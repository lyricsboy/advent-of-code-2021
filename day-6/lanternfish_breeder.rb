class LanternfishBreeder
  attr_reader :fish_ages

  BREEDING_CYCLE_LENGTH = 7

  def initialize(fish_ages)
    @fish_ages = fish_ages
  end

  def breed
    new_fish_count = 0
    fish_ages.count.times do |i|
      fish_age = fish_ages[i]
      if fish_age > 0
        fish_ages[i] = fish_age - 1
      elsif fish_age == 0
        fish_ages[i] = BREEDING_CYCLE_LENGTH - 1
        new_fish_count += 1
      else
        raise "Invalid fish age: #{fish_age}"
      end
    end
    @fish_ages.concat([BREEDING_CYCLE_LENGTH + 1] * new_fish_count)
  end
end