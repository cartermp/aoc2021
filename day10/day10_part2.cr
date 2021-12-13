def check_braces(line)
    stack = Array(Char).new
    matches = { '{' => '}', '[' => ']', '(' => ')', '<' => '>'}

    line.each_char do |c|
        if matches.has_key?(c)
            stack << c
        else
            if matches[stack.pop] != c
                return false
            end
        end
    end

    true
end

def score_braces(line)
    stack = Array(Char).new
    matches = { '{' => '}', '[' => ']', '(' => ')', '<' => '>'}
    scores = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }

    line.each_char do |c|
        if matches.has_key?(c)
            stack << c
        else
            stack.pop
        end
    end

    stack
        .reverse
        .map { |c| matches[c] }
        .reduce(0_i64) {|acc, c|
            acc *= 5_i64
            acc += scores[c]
        }
end

scores =
    File.read("data/day10/data.txt")
        .each_line
        .to_a
        .select { |line| check_braces(line) }
        .map { |line| score_braces(line) }
        .sort

puts (scores[Int32.new(scores.size/2)])
