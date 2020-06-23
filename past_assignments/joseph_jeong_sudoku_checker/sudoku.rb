require_relative 'board'
require 'byebug'

class Sudoku
    def initialize(puzzle)
        @board = Board.new(Board.from_file(puzzle))
        @size = 9
    end

    def get_player_input
        pos = nil
        value = nil

        until valid_position?(pos) && valid_value?(pos, value)
            pos, value = prompt
        end

        [pos, value]
    end

    def prompt
        puts "Please enter the position of the board you'd like to enter: (e.g., '2,3')"
        print "> "
        pos = gets.chomp.split(',').to_a.map(&:to_i)
        puts "Please enter the value: (1-9)"
        print "> "
        value = gets.chomp.to_i

        [pos, value]
    end

    def valid_position?(pos)
        row, col = pos

        # check if nil
        if row == nil || col == nil
            return false
        end

        # check out of bounds
        if row < 0 || row > size || col < 0 || col > size
            puts "Position is not on the board."
            return false
        end

        # check if empty
        if board[pos].value != nil
            puts "Position is already filled."
            return false
        end

        true
    end

    def valid_value?(pos, value)
        row, col = pos

        # check if nil
        if row == nil || col == nil
            return false
        end

        temp = board[pos].value  # save original value
        board[pos].value = value
        
        if !board.valid?
            board[pos].value = temp  # restore original value if not valid
            puts "That is not a valid move. Try again."
            return false
        end

        true
    end

    def play
        until board.solved?
            board.render
            pos, val = get_player_input
            board[pos] = val
        end
        
        board.render
        puts "Congratulations, you have solved this sudoku!"
    end

    private
    attr_accessor :board
    attr_reader :size
end

if $PROGRAM_NAME == __FILE__
    g = Sudoku.new("./puzzles/sudoku1_almost.txt")
    g.play
end