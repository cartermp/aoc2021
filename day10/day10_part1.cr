def check_braces(line)
    stack = Array(Char).new
    matches = { '{' => '}', '[' => ']', '(' => ')', '<' => '>'}
    scores = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }

    line.each_char do |c|
        if matches.has_key?(c)
            stack << c
        elsif matches[stack.pop] != c
            return scores[c]
        end
    end

    0
end

score =
    File.read("data/day10/data.txt")
        .each_line
        .map { |line| check_braces(line) }
        .sum

puts score
