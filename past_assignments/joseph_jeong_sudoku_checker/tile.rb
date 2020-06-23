require 'colorize'

class Tile
    attr_accessor :value
    attr_reader :pos

    def initialize(pos, value=nil)
        row,col = pos
        @pos = [row, col]
        @value = value
    end

    def to_s
        value != nil ? value.to_s.colorize(:red) : '*'.colorize(:blue)
    end
end