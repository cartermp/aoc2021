def lines
    File.open("data/day01/data.txt").each_line.map(&.to_i).to_a
end

prev = lines[0]
count = 0

lines.each do |line|
  if line > prev
    count += 1
  end

  prev = line
end

puts count