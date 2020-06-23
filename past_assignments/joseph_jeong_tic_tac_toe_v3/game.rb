require_relative "board"
require_relative "human_player"
require_relative "computer_player"
require "byebug"

class Game
    """
    - game starts by choosing size of n * board, and number of human players and computer players
    - second argument is a hash where the format is player mark (symbol): computer or human (boolean; true-> computer)
    """
    attr_reader :current_player

    def initialize(n, players_info)  
        @board = Board.new(n)
        @board_size = n
        @players = []

        player_num = 0  # numbering human and computer players
        comp_num = 0

        players_info.each do |mark, is_comp|
            if !is_comp
                current_player = HumanPlayer.new(mark)
                player_num += 1
                @players << [current_player, player_num]
            else
                current_player = ComputerPlayer.new(mark)
                comp_num += 1
                @players << [current_player, comp_num]
            end
        end

        @current_player = @players[0]  # first player is randomly selected
    end

    def switch_turn
        @players.rotate!  # rotate players to switch
        @current_player = @players[0]
    end

    def play  # GAME PLAY!
        play_mode = true  # this determines if game will be played again or not!
        while @board.empty_positions? && play_mode  # play game until board has no empty positions
            @board.print_board  # print board to users
            legal_pos = @board.legal_positions  # retrieve legal positions
            pos = @current_player[0].get_position(legal_pos)  # get position from current player (if player is a computer this is automatic)

            if @board.place_mark(pos, @current_player[0].mark_value)  # place the mark and check if anyone won
                if @board.win?(@current_player[0].mark_value)
                    @board.print_board
                    if @current_player[0].class == ComputerPlayer
                        puts "Computer #{@current_player[1]} won! Play Again? (Y/N)"
                    else
                        puts "Human #{@current_player[1]} won! Play Again? (Y/N)"
                    end
                    answer = gets.chomp
                    puts
                    if answer.upcase == 'Y'
                        @board = Board.new(@board_size)
                        play_mode = true
                    else
                        @board = Board.new(@board_size)
                        play_mode = false
                        return
                    end
                elsif !@board.win?(@current_player[0].mark_value) && !@board.empty_positions?  # check if it is tied
                    @board.print_board
                    puts "Tie Game! Play again? (Y/N)?"
                    answer = gets.chomp
                    puts
                    if answer.upcase == 'Y'
                        @board = Board.new(@board_size)
                        play_mode = true
                    else
                        @board = Board.new(@board_size)
                        play_mode = false
                        return
                    end
                else
                    self.switch_turn  # if no one won or tie exists, switch turns!
                end
            end
        end
    end
end


if $PROGRAM_NAME == __FILE__
    g = Game.new(4, :O => true, :X => true)
    g.play
end
