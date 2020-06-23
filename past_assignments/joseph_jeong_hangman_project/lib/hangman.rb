class Hangman
  # PART 1

  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    word = DICTIONARY.sample
    word
  end

  def initialize
    word = Hangman.random_word
    @secret_word = word
    @guess_word = Array.new(word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    end

    false
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index do |c, i|
      if char == c
        indices << i
      end
    end

    indices
  end

  def fill_indices(char, indices)
    @guess_word.each.with_index do |c, i|
      if indices.include?(i)
        @guess_word[i] = char
      end
    end
  end 
  #--------------------------------------------------------------

  # PART 2
  def try_guess(char)
    if !@secret_word.include?(char)
      @remaining_incorrect_guesses -= 1
    end

    indices = get_matching_indices(char)
    fill_indices(char, indices)

    if already_attempted?(char)
      puts "that has already been attempted"
      return false
    else
      @attempted_chars << char
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    char = gets.chomp
    return try_guess(char)
  end

  def win?
    if @guess_word.join('') == @secret_word
      puts 'WIN'
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if lose? || win?
      puts @secret_word
      return true
    else
      return false
    end
  end
end
