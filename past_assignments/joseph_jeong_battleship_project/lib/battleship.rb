require_relative "board"
require_relative "player"

class Battleship
    attr_accessor :board, :remaining_misses, :player

    def initialize(n)
        @player = Player.new()
        @board = Board.new(n)
        @remaining_misses = (n * n / 2)
    end

    def start_game
        self.board.place_random_ships
        print "Number of ships: #{self.board.num_ships}"
        puts
        self.board.print
    end

    def lose?
        if self.remaining_misses <= 0
            puts "you lose!"
            return true
        else
            return false
        end
    end

    def win?
        ships = self.board.num_ships
        if ships <= 0
            puts "you win!"
            return true
        else
            return false
        end
    end

    def game_over?
        if self.lose? || self.win?
            return true
        else
            return false
        end
    end

    def turn
        # debugger
        player_move = self.player.get_move
        self.remaining_misses -= 1 if !self.board.attack(player_move)
        self.board.print
        puts "remaining misses: #{self.remaining_misses.to_s}"
    end
end
