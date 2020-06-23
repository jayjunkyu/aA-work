class Player

    WORD_GHOST = "GHOST"

    attr_reader :ghost
    attr_accessor :name
    
    def initialize(name)
        @name = name
        @loss = 0
        @ghost = ""
    end

    def add_loss
        @loss += 1
        @ghost = WORD_GHOST[0...@loss]
    end
end