struct Point
    property x, y
    def initialize(@x : Int32, @y : Int32)
    end
end

def swap_if_smaller(a, b)
    if a > b
        { b, a }
    else
        { a, b }
    end
end

def fill_map(x1, x2, y1, y2, strategy, cloud_map)
    case strategy
    when "vertical"
        y1, y2 = swap_if_smaller(y1, y2)
        (y1..y2).each do |y_coord|
            key = Point.new(x1, y_coord)
            if cloud_map.has_key?(key)
                cloud_map[key] += 1
            else
                cloud_map[key] = 1
            end
        end
    when "horizontal"
        x1, x2 = swap_if_smaller(x1, x2)
        (x1..x2).each do |x_coord|
            key = Point.new(x_coord, y1)
            if cloud_map.has_key?(key)
                cloud_map[key] += 1
            else
                cloud_map[key] = 1
            end
        end
    when "diagonal"
        xs = x1 < x2 ? x1.to(x2) : x1.downto(x2)
        ys = y1 < y2 ? y1.to(y2) : y1.downto(y2)
        (xs).zip(ys).each do |x, y|
            key = Point.new(x, y)
            if cloud_map.has_key?(key)
                cloud_map[key] += 1
            else
                cloud_map[key] = 1
            end
        end
    end
end

points_pairs =
    File.open("data/day05/data.txt")
        .each_line
        .map { |line|
            p1, p2 = line.split(" -> ")
            x1, y1 = p1.split(',')
            x2, y2 = p2.split(',')
            { Point.new(x1.to_i, y1.to_i),
              Point.new(x2.to_i, y2.to_i) }
        }

cloud_map = Hash(Point, Int32).new

points_pairs.each do |point_pair|
    p1, p2 = point_pair
    strategy =
        if p1.x == p2.x
            "vertical"
        elsif p1.y == p2.y
            "horizontal"
        else
            "diagonal"
        end
    fill_map(p1.x, p2.x, p1.y, p2.y, strategy, cloud_map)
end

overlappers = cloud_map.select { |k, v| v > 1 }.size

puts overlappers