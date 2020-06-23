require "byebug"

class Board
    attr_reader :board

    def initialize(n)
        @board = Array.new(n) { Array.new(n, '_') }
    end

    def valid?(position)
        position[0] < @board.length && position[1] < @board.length
    end

    def empty?(position)
        row = position[0]
        col = position[1]

        self.board[row][col] == '_'
    end

    def place_mark(position, mark)
        if valid?(position) && empty?(position)
            row = position[0]
            col = position[1]
            @board[row][col] = mark
            return true
        else
            puts "Invalid position! Try again."
            return false
        end
    end

    def print_board
        (0...self.board.length).each do |row|
            (0...self.board[0].length).each do |col|
                print self.board[row][col] + "    "
            end
            puts "\n\n"
        end
    end

    def win_row?(mark)
        (0...self.board.length).each do |row|
            count = @board.length
            (0...self.board[0].length).each do |col|
                count -=1 if self.board[row][col] == mark
                return true if count == 0
            end
        end

        false
    end

    def win_col?(mark)
        (0...self.board[0].length).each do |col|
            count = @board.length
            (0...self.board.length).each do |row|
                count -=1 if self.board[row][col] == mark
                return true if count == 0
            end
        end

        false
    end

    def win_diagonal?(mark)
        left_to_right = @board.length
        (0...self.board.length).each do |i|
            left_to_right -=1 if self.board[i][i] == mark
            return true if left_to_right == 0
        end

        right_to_left = @board.length
        (0...self.board.length).each do |i|
            right_to_left -=1 if self.board[i][self.board.length-1-i] == mark
            return true if right_to_left == 0
        end

        false
    end

    def win?(mark)
        # debugger
        if self.win_col?(mark) || self.win_row?(mark) || self.win_diagonal?(mark)
            return true
        else
            return false
        end
    end

    def empty_positions?
        (0...self.board.length).each do |row|
            (0...self.board[0].length).each do |col|
                return true if self.board[row][col] == '_'
            end
        end

        false
    end
end

# board_1 = Board.new
# board_1.place_mark([0,1], 'X')
# board_1.place_mark([1,1], 'X')
# board_1.place_mark([2,0], 'X')
# p board_1.win_row?('X')
# p board_1.win_col?('X')
# p board_1.win_diagonal?('X')
# p board_1.win_diagonal?('X')