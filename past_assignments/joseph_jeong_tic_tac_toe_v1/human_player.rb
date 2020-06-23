class HumanPlayer
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position
        print "Enter your position (ex: 0 1) : "
        position = gets.chomp
        position = position.split()

        if ('0' > position[0] || '9' < position[0]) || ('0' > position[1] || '9' < position[1]) || position.length != 2
            raise "Incorrect values!"
        else
            return [position[0].to_i, position[1].to_i]
        end
    end
end