require_relative 'board'
require 'colorize'

class Tile
    def initialize(bombed = false)
        @bombed = bombed
        @revealed = false
        @flagged = false
    end

    def reveal
        revealed = !revealed
    end

    def flag
        flagged = !flagged
    end

    def neighbors
        #TODO: find neighbors recursively using board class
    end

    def neighbor_bomb_count
        #TODO: find neighbor's bomb count using board class
    end

    private
    attr_accessor :bombed, :revealed, :flagged
end

