class HumanPlayer
    attr_reader :name
    attr_accessor :correct_guesses, :last_2_guesses

    def initialize(name)
        @name = name
        @correct_guesses = []
        @last_2_guesses = []
    end

    def get_input            
        pos = gets.chomp.delete(' ').split(',')
        row = pos[0].to_i
        col = pos[1].to_i

        [row, col]
    end
end