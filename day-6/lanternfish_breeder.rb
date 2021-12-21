class LanternfishBreeder
  BREEDING_CYCLE_LENGTH = 7

  def initialize(fish_ages)
    @fish_age_groups = Array.new(BREEDING_CYCLE_LENGTH + 2, 0)
    counted_fish_ages = fish_ages.reduce(Hash.new) do |counts, age| 
      counts[age] = 1 + (counts[age] || 0)
      counts
    end
    counted_fish_ages.each do |age, count|
      @fish_age_groups[age] = count
    end
  end

  def fish_count
    @fish_age_groups.sum
  end

  def breed
    new_fish_count = @fish_age_groups.shift
    # everyone that created a new fish resets to N - 1, add that to the population
    @fish_age_groups[BREEDING_CYCLE_LENGTH - 1] = @fish_age_groups[BREEDING_CYCLE_LENGTH - 1] + new_fish_count
    @fish_age_groups[BREEDING_CYCLE_LENGTH + 1] = new_fish_count
    @fish_age_groups
  end
end