
keys_to_values =
{
    "acedgfb" => 8,
    "cdfbe" => 5,
    "gcdfa" => 2,
    "fbcad" => 3,
    "dab" => 7,
    "cefabd" => 9,
    "cdfgeb" => 6,
    "eafb" => 4,
    "cagedb" => 0,
    "ab" => 1
}

# Count is 2 --> it is a 1.
# Count is 3 --> it is a 7.
# Count is 4 --> it is a 4.
# Count is 8 --> it is an 8.
# Subsets of 8 -- 9, 6 and 0; orientation difference only.
# Subsets of

def recognize (str, keys_to_values, values_to_keys)
    case str.size
    when 2
        keys_to_values[str] = 1
        values_to_keys[1] = str
    when 3
        keys_to_values[str] = 7
        values_to_keys[7] = str
    when 4
        keys_to_values[str] = 4
        values_to_keys[4] = str
    when 5
        # ugh i can't figure this one out
    when 6
        # ugh i can't figure this one out
    when 7
        keys_to_values[str] = 8
        values_to_keys[8] = str
    end
end


ios =
    File.read("data/day08/test.txt")
        .each_line
        .map { |line|
            io = line.split("|")
            {input: io[0].strip.split(" "), output: io[1].strip.split(" ")}
        }
        .to_a

inputs = ios.map { |io| io[:input] }

puts inputs

