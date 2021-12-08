

def calc_day(fishies)
    to_add = Array(Int32).new

    (0..fishies.size-1).each do |idx|
        if fishies[idx] == 0
            fishies[idx] = 6
            to_add.push(8)
        else
            fishies[idx] -= 1
        end
    end

    if to_add.size > 0
        to_add.each do |fish|
            fishies.push(fish)
        end
    end

    fishies
end

def simulate(days, fishies)
    (1..days).each do |_|
        fishies = calc_day(fishies)
    end

    fishies
end


fishies =
    File.read("data/day06/test.txt").split(',')
        .map {|num| num.to_i }

fishies = simulate(80, fishies)

puts fishies.size