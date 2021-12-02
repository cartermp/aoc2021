def to_tuple(str)
    {str[0], str[1].to_i}
end

lines =
    File.open("data/day02/data.txt")
        .each_line
        .map { |line| to_tuple(line.split(" ")) }
        .to_a

horiztonal = 0
vertical = 0

lines.each do |line|
    command = line[0]
    amount = line[1]

    if command == "forward"
        horiztonal += amount
    elsif command == "down"
        vertical += amount
    elsif command == "up"
        vertical -= amount
    end
end

puts (horiztonal * vertical)