require "byebug"

class Board
    attr_reader :board  # getter for board

    def initialize(n)  # creates n x n board
        @board = Array.new(n) { Array.new(n, '_') }
    end

    def valid?(position)  # checking if position is within boundary
        position[0] < @board.length && position[1] < @board.length
    end

    def empty?(position)  # checking if position is empty or filled
        row = position[0]
        col = position[1]

        self.board[row][col] == '_'
    end

    def place_mark(position, mark)  # change position on board if valid and empty
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

    def print_board  # prints board
        (0...self.board.length).each do |row|
            (0...self.board[0].length).each do |col|
                print "#{self.board[row][col]}  "
            end
            puts "\n\n"
        end
    end

    def win_row?(mark)  # checks if there is a valid row to win
        (0...self.board.length).each do |row|
            count = @board.length
            (0...self.board[0].length).each do |col|
                count -=1 if self.board[row][col] == mark
                return true if count == 0
            end
        end

        false
    end

    def win_col?(mark)  # checks if there is a valid col to win
        (0...self.board[0].length).each do |col|
            count = @board.length
            (0...self.board.length).each do |row|
                count -=1 if self.board[row][col] == mark
                return true if count == 0
            end
        end

        false
    end

    def win_diagonal?(mark)  # checks if there is a valid diagonal to win
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

    def win?(mark)  # checks if there is a winner for a particular mark
        if self.win_col?(mark) || self.win_row?(mark) || self.win_diagonal?(mark)
            return true
        else
            return false
        end
    end

    def empty_positions?  # checks if there is any empty positions
        (0...self.board.length).each do |row|
            (0...self.board[0].length).each do |col|
                return true if self.board[row][col] == '_'
            end
        end

        false
    end

    def legal_positions  # returns the available legal positions left on the board
        legal_pos = []
        (0...self.board.length).each do |row|
            (0...self.board[0].length).each do |col|
                legal_pos << [row, col] if self.board[row][col] == '_'
            end
        end

        legal_pos
    end
end