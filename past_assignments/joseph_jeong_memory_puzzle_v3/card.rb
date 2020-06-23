# represents a single card on the board
class Card
    attr_reader :face_value, :face_up
    
    def initialize(face_value=nil)
        @face_value = face_value
        @face_up = false
    end

    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end

    def is_hidden?
        @face_up == false
    end

    # overridden == operation to compare with other card objects
    # returns true if card values are equal
    def ==(other_card)
        true if @face_value == other_card.face_value
    end

    # displays card value if card is faced up
    def display
        face_value_s = to_s(@face_value) 
        print face_value_s
    end

    private
    def to_s(value)
        value.to_s
    end
end


if $PROGRAM_NAME == __FILE__
    my_ace = Card.new(:ACE)
    my_other_ace = Card.new(:ACE)
    puts "they are the same" if my_ace == my_other_ace
    my_ace.reveal
    my_ace.display
    my_ace.hide
    my_ace.display
end