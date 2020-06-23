require "set"
require_relative "player"
require_relative "aiplayer"

class Game
    attr_reader :max_length

    ALPHABET = ('a'..'z').to_a

    def initialize
        @players = []
        @completed = []
        @fragment = ""
        @dictionary = File.open("dictionary.txt").read.downcase.split.to_set
        @max_length = @dictionary.max_by(&:length).length
    end

    def current_player
        @players[0]
    end

    def previous_player
        @players[-1]
    end

    def next_player!
        @players.rotate!
    end

    def take_turn(player)
        print "#{player.name}, enter letters you would like to add: "
        letters = gets.chomp.downcase

        until self.class.valid_play?(letters)
            puts "----------------------------------------"
            print "#{player.name}, enter only Enlgish letters with no space: "
            letters = gets.chomp.downcase
        end

        @fragment += letters

        if self.in_dictionary?
            player.add_loss
            puts "Take that letter #{player.name}."
        end
    end

    def self.valid_play?(string)
        alphabet = ('a'..'z').to_set
        string.split("").all? { |char| alphabet.include?(char) }
    end

    def game_over?(player)
        player.ghost == "GHOST"
    end

    def in_dictionary?(string = @fragment)
        if @dictionary.include?(string)
            @dictionary -= [string].to_set
            @completed << string
            @fragment = ""
            return true
        end

        false
    end

    def set_up
        print "Enter number of players: "
        human_players = gets.chomp.to_i
        (1..human_players).each do |num|
            print "Enter name for Player #{num}: "
            name = gets.chomp
            @players << Player.new(name)
        end

        # print "Enter number of computer players: "
        # computer_players = gets.chomp.to_i
        # (1..computer_players).each do |num|
        #     @players << Aiplayer.new("Computer " + num.to_s)
        # end

        @players.shuffle!
    end

    def display_all
        puts "----------------------------------------"
        puts "Current Fragment: #{@fragment}"
        puts "Completed Fragments : " + @completed.to_s
        @players.each.with_index do |player, i|
            puts "#{player.name}'s record: #{player.ghost}"
        end
    end

    def check_fragment
        if @fragment.length > self.max_length
            puts "----------------------------------------"
            puts "Fragment is over maximum length, reset!"
            @fragment = ""
        end
    end

    # def pick_winning_move(player)
    #     curr_fragment = ""
    #     @fragment.split('').each do |char|
    #         curr_fragment += char
    #     end
    #     step = 1
    #     index = 0
    #     while self.in_dictionary?(curr_fragment + ALPHABET[index])
    #     
    # end

    def play
        self.set_up

        while true
            self.take_turn(self.current_player)

            if game_over?(self.current_player)
                puts "#{self.current_player.name}... BYE!"
                @players.delete(self.current_player)
                if @players.length == 1
                    self.display_all
                    puts "#{self.current_player.name} has won the game!"
                    break
                end
            end

            self.check_fragment
            self.display_all
            self.next_player!
            
        end
    end
end

if $PROGRAM_NAME == __FILE__
    g = Game.new
    g.play
end