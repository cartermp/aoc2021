def check_braces(line)
    stack = Array(Char).new
    matches = { '{' => '}', '[' => ']', '(' => ')', '<' => '>'}
    scores = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }
    score = 0

    line.each_char do |c|
        if matches.has_key?(c)
            stack << c
        else
            if matches[stack.pop] != c
                return scores[c]
            end
        end
    end

    score
end

score =
    File.read("data/day10/data.txt")
        .each_line
        .to_a
        .map { |line| check_braces(line) }
        .sum

puts score
