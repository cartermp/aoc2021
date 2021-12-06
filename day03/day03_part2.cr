oxy_lines =
    File.open("data/day03/data.txt")
        .each_line
        .map { |line|
            line.chars.map {|char| char.to_i}
        }
        .to_a

co2_lines = oxy_lines.dup

def bit_array_to_num(arr)
    str = arr.join("")
    Int32.new(str, base: 2)
end

def get_ones_zeroes(idx, lines)
    ones = Array(Array(Int32)).new(0)
    zeroes = Array(Array(Int32)).new(0)

    lines.each do |line|
        if line[idx] == 1
            ones.unshift(line)
        else
            zeroes.unshift(line)
        end
    end

    {ones, zeroes}
end

while oxy_lines.size > 1
    (0..oxy_lines[0].size-1).each do |idx|
        break if oxy_lines.size == 1

        ones_zeroes = get_ones_zeroes(idx, oxy_lines)

        ones = ones_zeroes[0]
        zeroes = ones_zeroes[1]

        one_count = ones.size
        zero_count = zeroes.size

        if one_count >= zero_count
            zeroes.each do |zero|
                oxy_lines.delete(zero)
            end
        else
            ones.each do |one|
                oxy_lines.delete(one)
            end
        end
    end
end

while co2_lines.size > 1
    (0..co2_lines[0].size-1).each do |idx|
        break if co2_lines.size == 1

        ones_zeroes = get_ones_zeroes(idx, co2_lines)

        ones = ones_zeroes[0]
        zeroes = ones_zeroes[1]

        one_count = ones.size
        zero_count = zeroes.size

        if zero_count <= one_count
            ones.each do |one|
                co2_lines.delete(one)
            end
        else
            zeroes.each do |zero|
                co2_lines.delete(zero)
            end
        end
    end
end

oxy_generator_rating = bit_array_to_num(oxy_lines[0])
c02_scrubber_rating = bit_array_to_num(co2_lines[0])

life_support_rating = oxy_generator_rating * c02_scrubber_rating

puts life_support_rating
