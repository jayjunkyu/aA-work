require 'yaml'
require_relative 'board'
require 'byebug'

class MineSweeper
    # should be able to add features to choose difficulty
    LAYOUTS = {
        small: { grid_size: 9, num_bombs: 10 },
        medium: { grid_size: 16, num_bombs: 40 },
        large: { grid_size: 32, num_bombs: 160 }
      }.freeze

    def initialize(size)
        layout = LAYOUTS[size]
        @board = Board.new(layout[:grid_size], layout[:num_bombs])
    end

    def play
        until @board.won? || @board.lost?
            puts @board.render

            action, pos = get_move
            perform_move(action, pos)
        end

        if @board.won?
            puts "You win!"
        elsif @board.lost?  # show all the hidden tiles if lost
            puts "**Bomb hit!**"
            puts @board.reveal
        end
    end

    private

    def get_move
        puts "Enter action and position[row, col]. (i.e., e, 3, 4)"
        puts "HELP: e-> explore, f-> flag, s->save"
        print ">"
        action_type, row_s, col_s = gets.chomp.split(",")

        [action_type, [row_s.to_i, col_s.to_i]]
    end

    def perform_move(action_type, pos)
        title = @board[pos]

        case action_type
        when "f"
            title.toggle_flag
        when "e"
            title.explore
        when "s"
            save
        end
    end

    def save
        puts "Enter filename to save at:"
        filename = gets.chomp

        File.write(filename, YAML.dump(self))
    end
end

if $PROGRAM_NAME == __FILE__
    case ARGV.count
    when 0  # to start new game enter: ruby game.rb
        MineSweeper.new(:small).play
    when 1  # to load saved game enter: ruby game.rb "saved name"
        YAML.load_file(ARGV.shift).play
    end
end