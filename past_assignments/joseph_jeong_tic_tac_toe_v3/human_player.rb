class HumanPlayer  # human player object contains its mark and can get its current position
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position(legal_pos)
        while true
            print "Enter your position (ex: 0 1) : "
            position = gets.chomp
            position = position.delete(' ').split('')
            if position.length != 2  # errors if lenght is not two
                puts "Enter two digits between 0-9. Try again."
            else
                row = position[0].to_i
                col = position[1].to_i
                if legal_pos.include?([row, col])
                    return [position[0].to_i, position[1].to_i]
                else  # error if position is not an available legal position
                    puts "#{[row, col]} is not a legal position."
                end
            end
        end
    end
end