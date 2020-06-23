class ComputerPlayer  # computer player object contains its mark and randomly gets a legal position
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position(legal_pos)
        position = legal_pos.sample  # picks a random position from legal positions
        puts "Computer #{mark_value} chose position #{[position[0], position[1]]}"
        return position
    end
end