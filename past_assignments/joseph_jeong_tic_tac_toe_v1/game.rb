require_relative "board"
require_relative "human_player"
require "byebug"

class Game
    def initialize
        @board = Board.new
        @player1 = HumanPlayer.new('O')
        @player2 = HumanPlayer.new('X')
        @current_player = @player1
    end

    def switch_turn
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end

        @current_player
    end

    def play
        while @board.empty_positions?
            @board.print_board
            pos = @current_player.get_position
            p pos
            # debugger
            @board.place_mark(pos, @current_player.mark_value)
            if @board.win?(@current_player.mark_value)
                p "#{@current_player} won!"
                return
            elsif !@board.win?(@current_player.mark_value) && !@board.empty_positions?
                p "Tie Game !"
                return
            else
                self.switch_turn
            end
        end
    end
end
