counts_to_digits =
    {
        2 => 1,
        4 => 4,
        3 => 7,
        7 => 8
    }

output_count =
    File.read("data/day08/data.txt")
        .each_line
        .map { |line|
            io = line.split("|")
            {input: io[0].split(" "), output: io[1].split(" ")}
        }
        .map { |io| io[:output] }
        .flat_map { |o| o}
        .map { |o| o.chars.size }
        .select { |s| counts_to_digits.has_key?(s)}
        .size

puts output_count
