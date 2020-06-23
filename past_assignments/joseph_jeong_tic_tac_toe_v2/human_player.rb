class HumanPlayer
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position
        while true
            print "Enter your position (ex: 0 1) : "
            position = gets.chomp
            position = position.delete(' ').split('')

            if position.length != 2 || position[0].to_i < 0 || position[1].to_i < 0
                puts "Incorrect values! Try again."
            else
                row = position[0].to_i
                col = position[1].to_i
                return [position[0].to_i, position[1].to_i]
            end
        end
    end
end