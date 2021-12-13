def is_left_corner(idx, offset)
    idx % offset == 0
end

def is_right_corner(idx, offset)
    mod = idx % offset
    offset - mod == 1
end

def check_left(i, offset, data, num)
    is_left_corner(i, offset) || num < data[i-1]
end

def check_right(i, offset, data, num)
    is_right_corner(i, offset) || (i < data.size && num < data[i+1])
end

def check_top(i, offset, data, num)
    i - offset < 0 || (num < data[i-offset])
end

def check_bottom(i, offset, data, num)
    i + offset >= data.size || (num < data[i+offset])
end

def is_local_minima(idx, offset, data, num)
    check_left(idx, offset, data, num) &&
    check_right(idx, offset, data, num) &&
    check_top(idx, offset, data, num) &&
    check_bottom(idx, offset, data, num)
end

def count(data, offset)
    low_points = Array(Int32).new

    data.each_with_index do |num, i|
        if is_local_minima(i, offset, data, num)
            low_points << num
        end
    end

    low_points
end

lines =
    File.read("data/day09/data.txt")
        .each_line
        .flat_map { |line| line }
        .to_a

data =
    lines
        .map { |str| str.chars.map {|c| c.to_i } }
        .flat_map { |line| line}
        .to_a

offset = lines[0].size

low_points = count(data, offset)
risk_level = low_points.reduce(0) {|sum, num| sum + num + 1}
puts risk_level
