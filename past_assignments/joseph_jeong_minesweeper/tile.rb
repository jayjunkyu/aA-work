class Tile
    DELTAS = [
        [-1, -1],
        [-1, 0],
        [-1, 1],
        [0, -1],
        [0, 1],
        [1, -1],
        [1, 0],
        [1, 1]
    ].freeze

    attr_reader :pos

    def initialize(board, pos)
        @board, @pos = board, pos
        @bombed, @explored, @flagged = false, false, false
    end

    def bombed?
        @bombed
    end

    def explored?
        @explored
    end

    def flagged?
        @flagged
    end

    def plant_bomb
        @bombed = true
    end

    def neighbors
        # left, right, up, down, and four diagnols
        adjacent_coords = DELTAS.map do |(dx, dy)|
            [pos[0] + dx, pos[1] + dy]
        end.select do |row, col|  # filter out only tiles within boundary
            [row, col].all? do |coord|
                coord.between?(0, @board.grid_size-1)
            end
        end

        adjacent_coords.map { |pos| @board[pos] }  # return all valid neighbors  in an array
    end

    def adjacent_bomb_count
        neighbors.select(&:bombed?).count # return how many bombs are among neighbors
    end

    def explore
        # if user flagged, don't explore
        return self if flagged?

        # don't revisit
        return self if explored?

        # if there are no bombs around and tile is not bombed
        # explore each tile recursively
        # i.e., if one of the neighbor has zero adjacent bombs
        # then it will explore all 8 neighbors
        @explored = true
        if !bombed? && adjacent_bomb_count == 0
            neighbors.each(&:explore)
        end

        self
    end

    # overwriting object.inspect method
    # to show only certain attributes of this tile object
    def inspect
        # key -> value hash
        {pos: pos,
        bombed: bombed?,
        flagged: flagged?,
        explored: explored? }.inspect
    end

    def render
        if flagged?
            "F"  # flagged by user
        elsif explored?  # explored -> either safe or has nearby bombs
            adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
        else
            "*"  # unknown tile
        end
    end

    def reveal  # revealing the true board at the end
        if flagged?  # if flagged and bombed -> F but if wrongly flagged -> f
            bombed? ? "F" : "f"
        elsif bombed?  # if bombed but explored -> X else B
            explored? ? "X" : "B"
        else  # else if safe zone print _ else display adjacent bombs
            adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
        end
    end

    def toggle_flag
        # ignore flagging if explored tile
        @flagged = !@flagged unless @explored
    end
end