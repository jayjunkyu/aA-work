    class Flight
    attr_reader :passengers, :flight_number, :capacity

    def initialize(flight_number, capacity)
        @passengers = []
        @flight_number = flight_number
        @capacity = capacity
    end

    def full?
        self.passengers.length >= @capacity
    end

    def board_passenger(passenger)
        if passenger.has_flight?(self.flight_number) && !self.full?
            @passengers << passenger
        end
    end

    def list_passengers
        self.passengers.map { |passenger| passenger.name }
    end

    def [](index)
        self.passengers[index]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end