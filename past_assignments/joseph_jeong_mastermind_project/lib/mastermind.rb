require_relative "code"

class Mastermind
    attr_reader :secret_code

    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(other_code)
        puts self.secret_code.num_exact_matches(other_code)
        puts self.secret_code.num_near_matches(other_code)
    end

    def ask_user_for_guess
        puts "Enter a code"
        input = gets.chomp
        new_code = Code.from_string(input)
        self.print_matches(new_code)
        self.secret_code.pegs == new_code.pegs
    end
end
