crab_positions =
    File.read("data/day07/data.txt").split(',')
        .map {|num| num.to_i }
        .sort

total_fuel = 2147483647

(crab_positions[0]..crab_positions[crab_positions.size-1]).each do |pos|
    fuel = 0
    crab_positions.each do |crab_position|
        fuel += (crab_position - pos).abs
    end
    
    total_fuel = Math.min(total_fuel, fuel)
end

puts total_fuel
