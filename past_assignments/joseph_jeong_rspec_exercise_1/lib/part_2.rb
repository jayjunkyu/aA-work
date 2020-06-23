def hipsterfy(word)
    last = nil
    vowels = "aeiou"
    i = word.length - 1

    while i >= 0
        if vowels.include?(word[i])
            last = i
            break
        end

        i -=1
    end

    if last != nil
        word[last] = ''
    end

    word
end


def vowel_counts(s)
    count_vowels = Hash.new(0)
    vowels = "aeiou"

    s.each_char do |char|
        if vowels.include?(char.downcase)
            count_vowels[char.downcase] += 1
        end
    end

    count_vowels
end


def caesar_cipher(message, n)
    alphabet = ('a'..'z').to_a
    
    message.each_char.with_index do |char, idx|
        if alphabet.include?(char.downcase)
            new_idx = (alphabet.index(char.downcase) + n) % 26
            new_char = alphabet[new_idx]
            message[idx] = new_char
        end
    end

    message    
end