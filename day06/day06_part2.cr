def calc_day(fish_hash)
    reset_fish = {6 => 0_i64}
    new_fish = {8 => 0_i64}

    (fish_hash.keys).each do |fish|
        count = fish_hash[fish]

        fish_hash[fish] -= count

        if fish == 0
            reset_fish[6] += count
            new_fish[8] += count
        else
            fish_hash[fish - 1] += count
        end
    end

    if fish_hash.has_key?(6)
        fish_hash[6] += reset_fish[6]
    else
        fish_hash[6] = reset_fish[6]
    end

    if fish_hash.has_key?(8)
        fish_hash[8] += new_fish[8]
    else
        fish_hash[8] = new_fish[8]
    end
end

def simulate(days, fish_hash)
    (0..days-1).each do |_|
        calc_day(fish_hash)
    end
end

def count(fish_hash)
    fish_hash.values.sum
end

fishies =
    File.read("data/day06/data.txt").split(',')
        .map {|num| num.to_i }

fish_hash =
    {
        0 => 0_i64,
        1 => 0_i64,
        2 => 0_i64,
        3 => 0_i64,
        4 => 0_i64,
        5 => 0_i64,
        6 => 0_i64,
        7 => 0_i64,
        8 => 0_i64
    }

fishies.each do |fish|
    fish_hash[fish] += 1
end

simulate(256, fish_hash)

puts count(fish_hash)