require "byebug"

class Board

  attr_reader :size
  attr_accessor :grid

  def initialize(n)
    @grid = Array.new(n) { Array.new(n, :N) }
    @size = n * n
  end

  def [](position)
    row = position[0]
    col = position[1]
    self.grid[row][col]
  end

  def []=(position, value)
    row = position[0]
    col = position[1]
    self.grid[row][col] = value
  end

  def num_ships
    count_s = 0
    (0...self.grid.length).each do |row|
        (0...self.grid[0].length).each do |col|
            count_s +=1 if self.grid[row][col] == :S
        end
    end

    count_s
  end

  def attack(position)
    if self[position] == :S
        self[position] = :H
        puts "you sunk my battleship!"
        return true
    else
        self[position] = :X
        return false
    end
  end

  def place_random_ships
    #debugger
    n = Math.sqrt(@size)
    quarter_size = @size * 0.25
    (0...quarter_size).each do |_|
        rand_row = rand(0..n)
        rand_col = rand(0..n)
        rand_position = [rand_row, rand_col]

        until self[rand_position] != :S
            rand_row = rand(0..n)
            rand_col = rand(0..n)
            rand_position = [rand_row, rand_col]
        end

        self[rand_position] = :S
    end
  end

  def hidden_ships_grid
    n = self.grid.length
    hidden_grid = Array.new(n) { Array.new(n, :N) }
    #debugger
    (0...n).each do |row|
        (0...n).each do |col|
            hidden_grid[row][col] = :X if self[[row, col]] == :X
        end
    end

    hidden_grid
  end

  def self.print_grid(some_grid)
    # debugger
    n = some_grid.length
    all_rows = ""
    (0...n).each do |row|
        each_row = ""
        (0...n).each do |col|
            each_row += some_grid[row][col].to_s + " "
        end
        all_rows += each_row.strip + "\n"
    end

    puts all_rows
  end

  def cheat
    #debugger
    Board.print_grid(self.grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end
end
