def to_tuple(str)
    {str[0], str[1].to_i}
end

lines =
    File.open("data/day02/data.txt")
        .each_line
        .map { |line| to_tuple(line.split(" ")) }

x_pos = 0
y_pos = 0

lines.each do |line|
    command = line[0]
    amount = line[1]

    case command
    when "forward"
        x_pos += amount
    when "down"
        y_pos += amount
    when "up"
        y_pos -= amount
    end
end

puts (x_pos * y_pos)