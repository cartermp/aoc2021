lines = File.open("data/day01/data.txt").each_line.map(&.to_i)

count = 0

lines.each_cons_pair do |a, b|
  if a < b
    count += 1
  end
end

puts count