require_relative "board"
require_relative "human_player"
require "byebug"

class Game
    attr_reader :current_player

    def initialize(n, *marks)
        @board = Board.new(n)
        @board_size = n
        @players = []

        player_num = 0
        marks.each do |mark|
            current_player = HumanPlayer.new(mark)
            player_num += 1
            @players << [current_player, player_num]
        end

        @current_player = @players[0]
    end

    def switch_turn
        @players.rotate!
        @current_player = @players[0]
    end

    def play
        while @board.empty_positions?
            @board.print_board
            pos = @current_player[0].get_position
            # p pos
            # debugger
            if @board.place_mark(pos, @current_player[0].mark_value) 
                if @board.win?(@current_player[0].mark_value)
                    @board.print_board
                    puts "Player #{@current_player[1]} won! Play Again? (Y/N)"
                    answer = gets.chomp
                    puts
                    if answer.upcase == 'Y'
                        @board = Board.new(@board_size)
                        self.play
                    else
                        return
                    end
                elsif !@board.win?(@current_player[0].mark_value) && !@board.empty_positions?
                    @board.print_board
                    puts "Tie Game! Play again? (Y/N)?"
                    answer = gets.chomp
                    puts
                    if answer.upcase == 'Y'
                        @board = Board.new(@board_size)
                        self.play
                    else
                        return
                    end
                else
                    self.switch_turn
                end
            end
        end
    end
end
