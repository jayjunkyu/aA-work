require "byebug"

class ComputerPlayer
    attr_reader :name
    attr_accessor :known_cards, :matched_cards

    def initialize(name)
        @name = name
        @known_cards = {}
        @matched_cards = Hash.new { |h,k| h[k] = [] }
    end

    def get_input            
        if !@matched_cards.empty?
            key = @matched_cards.keys.sample
            pos = @matched_cards[key]
            @matched_cards.delete(key)
            return pos
        end

        []
    end

    def add_memory(row, col, value)
        if @known_cards.has_key?(value)
            if @known_cards[value] != [row, col]
                # debugger
                @matched_cards[value] << [row, col]
                @matched_cards[value] << @known_cards[value]
                return
            end
        end

        @known_cards[value] = [row, col]
    end
end