class Solver
    def initialize
        @visited = Set.new
        @solved = false
    end

    def find_starting_point(board)
        rows = board.length
        cols = rows

        (0...rows).each do |row|
            (0...cols).each do |col|
                if board[row][col] == '*'
                    

    
    end

    def depth_first_search(board, row, col)
        if !board.valid?
            return false
        end

        
    end


        
    end
end