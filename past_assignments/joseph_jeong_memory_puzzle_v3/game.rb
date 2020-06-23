require_relative "board"
require_relative "computerplayer"
require "byebug"

class Game
    def initialize(n)
        @my_board = Board.new(n)
        @my_board.populate # populate board with random alphabet symbols when initialized
        @player = ComputerPlayer.new("SkyNet")
        @size = n
        @remaining_pairs = @my_board.unique_pairs
        @tries = 0
    end

    # letting the user to memorize for 2 seconds before the game starts!
    def display_all
        @my_board.cheat
        puts "---------------------------"
        puts "Try memorizing this board!.. SkyNet!"
        puts "---------------------------"
        sleep(@size)
        system("clear")
        self.display_board
    end

    # display the whole board to the user
    def display_board
        system("clear")
        @my_board.render
        puts "Failed Attempts: #{@tries}, Remaining Pairs: #{@remaining_pairs}"
    end

    def won?
        @remaining_pairs == 0
    end

    def play
        self.display_all
        selected = []
        count = 0

        until self.won?
            count = 0
            prev = []
            until count == 2
                # s
                pos = @player.get_input
                if pos.empty?
                    until selected.length == 2
                        row = (0...@size).to_a.sample
                        col = (0...@size).to_a.sample
                        selected << [row, col] if !prev.include?([row,col, @my_board[row,col].face_value])
                    end
                elsif pos.length == 2
                    pos.each do |p|
                        selected << pos
                    end
                else
                    selected << pos
                end
            
                selected.each do |pos|
                    debugger
                    puts "Please enter the position of the card you'd like to flip (e.g., '2,3')"
                    row = pos[0]
                    col = pos[1]
                    @my_board.reveal(row,col)
                    self.display_board
                    @player.add_memory(row, col, @my_board[row,col].face_value)
                    if !prev.include?([row,col, @my_board[row,col].face_value])
                        prev << [row, col, @my_board[row,col].face_value] 
                        count += 1
                    end
                end
                
                # debugger
                if count == 2
                    # debugger
                    if prev[0][2] != prev[1][2]
                        @my_board.hide(prev[0][0],prev[0][1])
                        @my_board.hide(prev[1][0],prev[0][1])
                        prev = []
                        selected = []
                        self.display_board
                        puts "Not noice."
                        @tries += 1
                    else
                        prev = []
                        selected = []
                        puts "Noice"
                        @remaining_pairs -= 1
                        self.display_board
                    end
                end
            end
        end

        puts "I underestimated you #{@player.name}... MISSION COMPLETE!"
    end
end

if $PROGRAM_NAME == __FILE__
    g = Game.new(4)
    g.play
end