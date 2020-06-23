require_relative "board.rb"

class Game
    def initialize(n)
        @my_board = Board.new(n)

        # populate board with random alphabet symbols when initialized
        @my_board.populate  

        @size = n
        @remaining_pairs = @my_board.unique_pairs
        @tries = 0
        @correct_guesses = []
        @last_2_guesses = []
    end

    # letting the user to memorize for 2 seconds before the game starts!
    def display_all
        @my_board.cheat
        puts "--------------------------"
        puts "Try memorizing this board!"
        puts "--------------------------"
        sleep(@size)
        system("clear")
        self.display_board
    end

    def valid_position?(row, col)
        # checking if arguments are integers
        if !(row.is_a?(Integer) || col.is_a?(Integer))
            return false
        end

        # checking if arguments are within bound of the board
        if !(row >=0 && row < @size && col >=0 && col < @size)
            return false
        end

        # checking if arugments are already guessed correctly before
        # or if this position is the same one as the first selection
        if @correct_guesses.include?([row, col]) || @last_2_guesses.include?([row, col])
            return false
        end

        true
    end

    # we are done selecting a pair when last_2_guesses has two positions stored
    def done_selecting_two?(row, col)
        @last_2_guesses.length == 2
    end

    # hiding the given guesses
    def hide_wrong_guesses(*pos)
        pos.each do |p|
            row = p[0]
            col = p[1]
            @my_board.hide(row, col)
        end
    end

    # if user finds a correct pair, we store the positions
    def add_correct_guesses(pos)
        @correct_guesses << pos
    end

    # display the whole board to the user
    def display_board
        system("clear")
        @my_board.render
        puts "Failed Attempts: #{@tries}, Remaining Pairs: #{@remaining_pairs}"
    end

    # checking user's guesses...
    # hide guesses if wrong
    # leave guesses revealed if correct
    def check_user_guesses
        if @last_2_guesses.length == 2
            if @my_board[*@last_2_guesses[0]] == @my_board[*@last_2_guesses[1]]
                self.add_correct_guesses(@last_2_guesses[0])
                self.add_correct_guesses(@last_2_guesses[1])
                @remaining_pairs -= 1
                self.display_board
                puts "Noice."
            else
                self.hide_wrong_guesses(@last_2_guesses[0])
                self.hide_wrong_guesses(@last_2_guesses[1])
                @tries += 1
                self.display_board  # since we hid the values, need to re-display to user
                puts "Not noice."
            end
            @last_2_guesses = []
        end
    end

    def won?
        @remaining_pairs == 0
    end

    def play
        self.display_all

        until self.won?
            row, col = nil, nil
            until self.done_selecting_two?(row, col)
                puts "Please enter the position of the card you'd like to flip (e.g., '2,3')"

                pos = gets.chomp.delete(' ').split(',')
                row = pos[0].to_i
                col = pos[1].to_i

                if self.valid_position?(row,col)
                    @last_2_guesses << [row,col] if !@last_2_guesses.include?([row,col])
                    @my_board.reveal(row, col)
                    self.display_board
                end
            end

            puts "Checking board..."
            sleep(1)
            self.check_user_guesses
        end

        puts "I underestimated you... MISSION COMPLETE!"
    end
end

if $PROGRAM_NAME == __FILE__
    g = Game.new(6)
    g.play
end