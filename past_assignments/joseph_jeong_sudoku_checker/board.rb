require_relative 'tile'
require "byebug"

class Board
    def self.from_file(file)
        text = File.readlines(file).map(&:chomp)
        new_arr = Array.new(9) { Array.new(9) }

        text.each_with_index do |row, i|
            row.split('').each_with_index do |num, j|
                num != '0' ? num = num.to_i : num = nil
                new_arr[i][j] = Tile.new([i,j], num)
            end
        end
        
        new_arr
    end

    def initialize(grid)
        @grid = grid
        @size = 9
    end

    def [](pos)
        row,col = pos
        grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        grid[row][col] = Tile.new(pos, value)
    end

    def render
        system('clear')
        puts "   #{(0...size).to_a.join(' ')}"
        grid.each_with_index do |row, i|
            puts " #{i} #{row.join(' ')}"
        end
    end

    def solved?
        rows = Array.new(9) { Hash.new(0) }
        cols = Array.new(9) { Hash.new(0) }
        boxes = Array.new(9) { Hash.new(0) }

        grid.each_with_index do |row, i|
            row.each_with_index do |col, j|
                num = grid[i][j].value
                return false if num == nil

                box_index = i / 3 * 3 + (j / 3)

                rows[i][num] += 1
                cols[j][num] += 1
                boxes[box_index][num] += 1

                if rows[i][num] > 1 || cols[j][num] > 1 || 
                    boxes[box_index][num] > 1
                    return false
                end
            end
        end

        true
    end

    def valid?
        rows = Array.new(9) { Hash.new(0) }
        cols = Array.new(9) { Hash.new(0) }
        boxes = Array.new(9) { Hash.new(0) }

        grid.each_with_index do |row, i|
            row.each_with_index do |col, j|
                num = grid[i][j].value
                next if num == nil

                box_index = i / 3 * 3 + (j / 3)

                rows[i][num] += 1
                cols[j][num] += 1
                boxes[box_index][num] += 1

                if rows[i][num] > 1 || cols[j][num] > 1 || 
                    boxes[box_index][num] > 1
                    return false
                end
            end
        end

        true
    end

    private
    attr_accessor :grid
    attr_reader :size
end

my_board = Board.new(Board.from_file('./puzzles/sudoku1.txt'))
p my_board[[0,0]].value