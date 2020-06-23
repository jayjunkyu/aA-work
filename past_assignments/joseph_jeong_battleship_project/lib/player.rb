class Player
    def get_move
        puts "enter a position with coordinates separated with a space like `4 7`"
        position = gets.chomp
        position = position.split()
        position = position.map { |num| num = num.to_i }
        position
    end
end
