class BingoValue
    def initialize(value : Int32)
        @value = value
        @marked = false
    end

    def mark
        @marked = true
    end

    def value
        @value
    end

    def marked? : Bool
        @marked
    end
end

class BingoBoard
    def initialize(rows : Array(Array(BingoValue)), cols : Array(Array(BingoValue)))
        @rows = rows
        @cols = cols
    end

    def rows
        @rows
    end

    def cols 
        @cols
    end

    def mark_value(x)
        @rows.each do |row|
            row.each do |bingo_value|
                if bingo_value.value == x
                    bingo_value.mark
                end
            end
        end
    end

    def is_bingo?
        @rows.any? { |row|
            row.all? { |bingo_value| bingo_value.marked? }
        } ||
        @cols.any? { |col|
            col.all? { |bingo_value| bingo_value.marked? }
        }
    end

    def sum_unmarked()
        @rows.sum { |row|
            row.sum { |bv|
                if !bv.marked?
                    bv.value
                else
                    0
                end
            }
        }
    end
end

def get_cols(rows)
    cols = Array(Array(BingoValue)).new()

    (0..rows[0].size-1).each do |idx|
        col_vals = Array(BingoValue).new()

        rows.each do |row|
            col_vals.push(row[idx])
        end

        cols.push(col_vals)
    end

    cols
end

def get_boards(lines)
    boards = Array(BingoBoard).new()
    rows = Array(Array(BingoValue)).new()

    lines.each do |line|
        if line.size == 0
            cols = get_cols(rows)
            boards.push(BingoBoard.new(rows, cols))
            rows = Array(Array(BingoValue)).new()
        else
            row =
                line
                    .split(' ')
                    .select{ |s| s.size > 0 }
                    .map{ |s| BingoValue.new(s.to_i) }
            rows.push(row)
        end
    end

    cols = get_cols(rows)
    boards.push(BingoBoard.new(rows, cols))
    boards
end

def play_bingo(nums, boards)
    nums.each do |num|
        bingo_board =
            boards.each do |board|
                board.mark_value(num)
                if board.is_bingo?
                    break board
                end
            end
    
        if bingo_board
            puts (bingo_board.sum_unmarked() * num)
            break
        end
    end
end

lines = File.open("data/day04/data.txt").each_line.to_a
nums = lines[0].split(',').map{ |s| s.to_i }
boards = get_boards(lines[2..])
play_bingo(nums, boards)