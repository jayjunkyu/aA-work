require_relative 'tile'

class Board
    attr_reader :grid_size, :num_bombs

    def initialize(grid_size, num_bombs)
        @grid_size, @num_bombs = grid_size, num_bombs

        generate_board
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def lost?
        @grid.flatten.any? { |tile| tile.bombed? && tile.explored? }
    end

    def render(reveal = false)
        # render -> displaying current board
        # reveal -> displaying the result
        @grid.map do |row|
            row.map do |tile|
                reveal ? tile.reveal : tile.render
            end.join(" ")
        end.join("\n")
    end

    def reveal
        render(true)
    end

    def won?
        @grid.flatten.all? { |tile| tile.bombed? != tile.explored? }
    end

    private
    
    def generate_board
        # notice how the board itself is passed to all the tiles
        # so each tile can explore itself to render other tiles
        @grid = Array.new(@grid_size) do |row|
            Array.new(@grid_size) { |col| Tile.new(self, [row, col]) }
        end

        plant_bombs
    end

    def plant_bombs
        total_bombs = 0
        while total_bombs < @num_bombs
            # picking random pos up to @grid_size-1
            rand_pos = Array.new(2) { rand(@grid_size) }

            tile = self[rand_pos]
            next if tile.bombed?

            tile.plant_bomb
            total_bombs += 1
        end

        nil
    end
end

# my_board = Board.new(8, 10)
# puts my_board[[0,0]].inspect