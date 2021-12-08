crab_positions =
    File.read("data/day07/data.txt").split(',')
        .map {|num| num.to_i }

total_fuel = 2147483647

(crab_positions.min..crab_positions.max).each do |pos|
    fuel = crab_positions.reduce(0) {|sum, c_pos| sum + (c_pos - pos).abs }
    total_fuel = Math.min(total_fuel, fuel)
end

puts total_fuel
