crab_positions =
    File.read("data/day07/test.txt").split(',')
        .map {|num| num.to_i }
        .sort

total_fuel = 2147483647

(crab_positions[0]..crab_positions[crab_positions.size-1]).each do |pos|
    fuel = crab_positions.reduce(0) { |sum, c_pos|
        dist = (pos - c_pos).abs
        sum + (dist * (dist + 1)) / 2
    }
    total_fuel = Math.min(total_fuel, fuel)
end

puts total_fuel
