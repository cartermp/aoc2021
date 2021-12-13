def is_left_border(idx, offset)
    idx % offset == 0
end

def is_right_border(idx, offset)
    mod = idx % offset
    offset - mod == 1
end

def check_left(i, offset, data, num)
    is_left_border(i, offset) || num < data[i-1][:num]
end

def check_right(i, offset, data, num)
    is_right_border(i, offset) || (i < data.size && num < data[i+1][:num])
end

def check_top(i, offset, data, num)
    i - offset < 0 || (num < data[i-offset][:num])
end

def check_bottom(i, offset, data, num)
    i + offset >= data.size || (num < data[i+offset][:num])
end

def is_local_minima(idx, offset, data, num)
    check_left(idx, offset, data, num) &&
    check_right(idx, offset, data, num) &&
    check_top(idx, offset, data, num) &&
    check_bottom(idx, offset, data, num)
end

def count(data, offset)
    low_points = Array(NamedTuple(idx: Int32, num: Int32)).new

    data.each_with_index do |datum, i|
        if is_local_minima(i, offset, data, datum[:num])
            low_points << {idx: i, num: datum[:num]}
        end
    end

    low_points
end

def crawl(i, offset, data, count)
    if data[i][:marked]
        return count
    end

    num = data[i][:num]
    data[i] = { marked: true, num: num }
    local_count = 1

    if i - 1 > -1 && !is_left_border(i, offset) && !data[i-1][:marked] && (num < data[i-1][:num] && data[i-1][:num] < 9)
        local_count += crawl(i-1, offset, data, local_count)
    end

    if i + 1 < data.size && !is_right_border(i, offset) && !data[i+1][:marked] && (num < data[i+1][:num] && data[i+1][:num] < 9)
        local_count += crawl(i+1, offset, data, local_count)
    end

    if i - offset > 0 && !data[i-offset][:marked] && (num < data[i-offset][:num] && data[i-offset][:num] < 9)
        local_count += crawl(i-offset, offset, data, local_count)
    end

    if i + offset < data.size && !data[i+offset][:marked] && (num < data[i+offset][:num] && data[i+offset][:num] < 9)
        local_count += crawl(i+offset, offset, data, local_count)
    end
    
    local_count
end

def crawl_basin(minimas, offset, data)
    basin_sizes = Array(Int32).new
    minimas.each do |minima|
        basin_sizes << crawl(minima[:idx], offset, data, 1)
    end
    basin_sizes
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
        .map { |x| { marked: false, num: x } }
        .to_a

offset = lines[0].size

low_points = count(data, offset)
basin_sizes = crawl_basin(low_points, offset, data)
sorted = basin_sizes.sort.reverse

puts sorted[0..2].reduce(1) {|sum, num| sum * num}
