require_relative "room"

class Hotel
    def initialize(name, rooms)
        @name = name
        @rooms = {}
        rooms.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
        # parts = @name.split()
        # parts.each do |part|
        #     part.capitalize!
        # end

        # parts.join(' ')
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        @rooms.has_key?(room_name)
        # if @rooms.keys.include?(room_name)
        #     return true
        # end

        # false
    end

    def check_in(person, room_name)
        if !self.room_exists?(room_name)
            puts "sorry, room does not exist"
        else
            if @rooms[room_name].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        @rooms.values.any? { |room| room.available_space > 0 }
        # @rooms.each_key do |room_name|
        #     if !@rooms[room_name].full?
        #         return true
        #     end
        # end
        
        # false
    end

    def list_rooms
        @rooms.each_key do |room_name|
            puts "#{room_name}: #{@rooms[room_name].available_space}"
        end
    end
end
