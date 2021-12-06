lines =
    File.open("data/day03/data.txt")
        .each_line
        .map { |line|
            line.chars.map {|char| char.to_i}
        }
        .to_a

def bit_array_to_num(arr)
    str = arr.join("")
    Int32.new(str, base: 2)
end

gamma_rate = Array.new(lines[0].size) {|_| 0}
episilon_rate = Array.new(lines[0].size) {|_| 0}

(0..gamma_rate.size-1).each do |idx|
    one_count = 0
    zero_count = 0

    lines.each do |line|
        if line[idx] == 1
            one_count += 1
        else
            zero_count += 1
        end
    end

    gamma_rate[idx] = one_count > zero_count ? 1 : 0
    episilon_rate[idx] = one_count > zero_count ? 0 : 1
end


gamma = bit_array_to_num(gamma_rate)
epsilon = bit_array_to_num(episilon_rate)

puts (gamma * epsilon)
