require_relative "card"

# Board is responsible of keeping track of all cards
class Board
    attr_reader :unique_pairs

    ALPHABET = (:A..:Z).to_a
    SPACE = " "
    NEWLINE = "\n"

    def initialize(n)
        raise "Initialize with an even number." if n % 2 != 0
        
        @grid = Array.new(n) { Array.new(n, Card.new) }
        @size = @grid.length
        @unique_pairs = (@size ** 2) / 2
    end

    def [](row, col)
        @grid[row][col]
    end

    def []=(row, col, card)
        @grid[row][col] = card
    end

    def hide(row, col)
        @grid[row][col].hide
    end

    def reveal(row, col)
        @grid[row][col].reveal
    end

    def populate
        # shuffle alphabet then grab unique pairs
        # then multiply by two to get a pair and shuffle again

        deck = (ALPHABET.shuffle[0...@unique_pairs] * 2).shuffle
        idx = 0

        (0...@size).each do |row|
            (0...@size).each do |col|
                @grid[row][col] = Card.new(deck[idx])
                idx += 1
            end
        end
    end

    def render
        (0..@size).each do |row|
            (0..@size).each do |col|
                # printing table for col
                if row-1 == -1 && col-1 != -1
                    print (col-1).to_s + SPACE
                # printing table for row
                elsif row-1 != -1 && col-1 == -1  
                    print NEWLINE + (row-1).to_s
                # printing non-hidden cards
                elsif row > 0 && col > 0 && !@grid[row-1][col-1].is_hidden?
                    print SPACE
                    @grid[row-1][col-1].display
                # printing uniform space if hidden
                else
                    print SPACE * 2
                end
            end
        end
        # printing new line for a cleaner look
        print NEWLINE          
    end

    def cheat
        (0..@size).each do |row|
            (0..@size).each do |col|
                # printing table for col
                if row-1 == -1 && col-1 != -1
                    print (col-1).to_s + SPACE
                # printing table for row
                elsif row-1 != -1 && col-1 == -1  
                    print NEWLINE + (row-1).to_s
                # printing non-hidden cards
                elsif row > 0 && col > 0
                    print SPACE
                    @grid[row-1][col-1].display
                # printing uniform space if hidden
                else
                    print SPACE * 2
                end
            end
        end
        # printing new line for a cleaner look
        print NEWLINE   
    end
end

if $PROGRAM_NAME == __FILE__
    my_board = Board.new(4)
    my_board.populate
    # my_board[0,0].reveal
    # my_board[1,1].reveal
    # my_board[2,2].reveal
    my_board.reveal(0,0)
    # my_board[0,1].reveal
    # my_board[0,2].reveal
    # my_board[0,3].reveal
    # my_board[1,0].reveal
    # my_board[1,1].reveal
    # my_board[1,2].reveal
    # my_board[1,3].reveal
    # my_board[2,0].reveal
    # my_board[2,1].reveal
    # my_board[2,2].reveal
    # my_board[2,3].reveal
    # my_board[3,0].reveal
    # my_board[3,1].reveal
    # my_board[3,2].reveal
    my_board.reveal(3,3)
    my_board.render
end