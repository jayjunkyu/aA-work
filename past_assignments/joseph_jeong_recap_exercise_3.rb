require "byebug"

def no_dupes?(arr)
    dupes = Hash.new(0)

    arr.each do |ele|
        dupes[ele] += 1
    end

    new_arr = []

    dupes.each_key do |key|
        if dupes[key] == 1
            new_arr << key
        end
    end
    
    new_arr
end

p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []
p "---------------------------------------------------"

def no_consecutive_repeats?(arr)
    (0...arr.length-2).each do |i|
        if arr[i] == arr[i+1]
            return false
        end
    end

    true
end

p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true
p "---------------------------------------------------"

def char_indices(str)
    str_hash = Hash.new { |h,k| h[k] = Array.new }

    str.each_char.with_index do |char, i|
        str_hash[char] << i
    end

    str_hash
end

p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}
p "---------------------------------------------------"

def longest_streak(str)
    # debugger
    longest_streak = str[0]
    cur_streak = str[0]

    (1...str.length).each do |i|
        if str[i] == cur_streak[0]
            cur_streak += str[i]
        elsif cur_streak.length >= longest_streak.length
            longest_streak = cur_streak.dup
            cur_streak = str[i]
        else
            cur_streak = str[i]
        end
    end

    if cur_streak.length == longest_streak.length
        longest_streak = cur_streak
    end

    longest_streak
end

p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'
p "---------------------------------------------------"


def is_prime?(num)
    if num < 2
        return false
    end

    (2...Math.sqrt(num)).each do |factor|
        if num % factor == 0
            return false
        end
    end

    true
end


def bi_prime?(num)
    (2...num).each do |factor|
        if num % factor == 0 && is_prime?(factor) && is_prime?(num / factor)
            return true
        end
    end

    false
end

p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false
p "---------------------------------------------------"

def vigenere_cipher(word, keys)
    alphabet = ("a".."z").to_a
    new_word = ""
    # debugger

    i = 0
    while i < word.length
        keys.each do |offset|
            break if i == word.length
            new_idx = (word[i].ord - 'a'.ord + offset) % alphabet.length
            new_word += alphabet[new_idx]
            i += 1
        end    
    end

    new_word
end

p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"
p "---------------------------------------------------"

def vowel_rotate(str)
    # debugger
    vowels = "aeiou"
    prev_vowel = ""
    first_idx = 0
    has_vowels = false
    result = ""

    str.each_char.with_index do |char, i|
        if vowels.include?(char) && prev_vowel.length == 0
            prev_vowel = char
            first_idx = i
            result += char
            has_vowels = true
        elsif vowels.include?(char)
            result += prev_vowel
            prev_vowel = char
        else
            result += char
        end
    end

    result[first_idx] = prev_vowel if has_vowels

    result  
end

p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"
p "---------------------------------------------------"

class String
    attr_accessor :self

    def select(&prc)
        if prc.nil?
            return []
        end

        new_string = ""

        self.each_char do |char|
            if prc.call(char)
                new_string += char
            end
        end

        new_string
    end

    def map!(&prc)
        new_string = ""
        
        self.each_char.with_index do |char, i|
            new_string += prc.call(char,i)
        end

        self.replace(new_string)
    end
end

p"app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""
p "---------------------------------------------------"

# Examples
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"
p "---------------------------------------------------"

def multiply(a,b)
    if b == 1
        return a
    elsif b == -1
        return -a
    end
    
    if a < 0 && b < 0
        return -a + multiply(a, b+1)
    elsif a < 0  && b > 0
        return a + multiply(a, b-1)
    elsif a > 0 && b < 0
        return b + multiply(b, a-1)
    else
        return a + multiply(a, b-1)
    end
end

p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18
p "---------------------------------------------------"

# how to do it recursively?
def lucas_sequence(n)
    if n == 0
        return []
    end

    if n == 1
        return [2]
    end

    if n == 2
        return [2, 1]
    end

    result = [2, 1]

    (n-2).times do
        result << result[-1] + result[-2]
    end

    result
end

p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]
p "---------------------------------------------------"

def prime_factorization(num)

end