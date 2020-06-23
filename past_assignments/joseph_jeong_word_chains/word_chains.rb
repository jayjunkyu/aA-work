require 'set'

class WordChainer
    ALPHABET = ('a'..'z').to_a  # used to generate all possible new words

    # read given dictionary
    def initialize(dictionary_file_name)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
        @current_words = []
        @all_seen_words = {}
    end

    # returns array of adjacent words
    def adjacent_words(word)
        adjacents = []

        (0...word.length).each do |i|
            ALPHABET.each do |char|
                if char != word[i]
                    new_word = word[0...i] + char + word[i+1..-1]
                    adjacents << new_word if dictionary.include?(new_word)
                end
            end
        end

        adjacents
    end

    # prints path from source to target
    def run(source, target)
        current_words << source  # current_words starts with source
        all_seen_words[source] = nil  # word -> the word before transformation
        while !all_seen_words.keys.include?(target)
            new_current_words = []
            current_words.each do |word|
                explore_current_words(word, new_current_words)  # tracking all adjacent words
            end
        end

        p build_path(target)
    end

    def explore_current_words(word, new_current_words)
        adjacent_words(word).each do |adjacent_word|
            next if all_seen_words.keys.include?(adjacent_word)
            new_current_words << adjacent_word
            all_seen_words[adjacent_word] = word
        end

        @current_words = new_current_words
    end

    def build_path(target)
        path = [target]

        until all_seen_words[target] == nil  # we know that if value is nil, the key is the original source
            path.unshift(all_seen_words[target])
            target = all_seen_words[target]
        end

        path
    end

    private
    
    attr_reader :dictionary
    attr_accessor :current_words, :all_seen_words
end

if $PROGRAM_NAME == __FILE__
    my_word_chain = WordChainer.new("dictionary.txt")
    my_word_chain.run('duck', 'ruby')
end
