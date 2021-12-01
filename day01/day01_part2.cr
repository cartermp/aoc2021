def lines
    File.open("data/day01/data.txt")
      .each_line
      .map(&.to_i)
      .to_a
end

prev = {0, 1, 2}.sum { |i| lines[i] }
count = 0

(0..lines.size-3).each do |idx|
  sum = {0, 1, 2}.sum { |i| lines[idx + i] }
  if sum > prev
    count += 1
  end

  prev = sum
end

puts count