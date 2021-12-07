struct Point
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end
end

def swap_if_smaller(one, two)
    if one > two
        { two, one }
    else
        { one, two }
    end
end

def fill_map_xs(x1, x2, y_coord, cloud_map)
    x1, x2 = swap_if_smaller(x1, x2)
    (x1..x2).each do |x_coord|
        key = Point.new(x_coord, y_coord)
        if cloud_map.has_key?(key)
            cloud_map[key] += 1
        else
            cloud_map[key] = 1
        end
    end
end

def fill_map_ys(y1, y2, x_coord, cloud_map)
    y1, y2 = swap_if_smaller(y1, y2)
    (y1..y2).each do |y_coord|
        key = Point.new(x_coord, y_coord)
        if cloud_map.has_key?(key)
            cloud_map[key] += 1
        else
            cloud_map[key] = 1
        end
    end
end

points_pairs =
    File.open("data/day05/test.txt")
        .each_line
        .map { |line|
            one_two = line.split(" -> ")
            x1y1 = one_two[0].split(',')
            x2y2 = one_two[1].split(',')
            { Point.new(x1y1[0].to_i, x1y1[1].to_i),
              Point.new(x2y2[0].to_i, x2y2[1].to_i) }
        }
        .to_a

cloud_map = Hash(Point, Int32).new

points_pairs.each do |point_pair|
    p1, p2 = point_pair
    if p1.x == p2.x
        fill_map_ys(p1.y, p2.y, p1.x, cloud_map)
    elsif p1.y == p2.y
        fill_map_xs(p1.x, p2.x, p1.y, cloud_map)
    end
end

overlappers = cloud_map.select { |k, v| v > 1 }.size

puts overlappers