def select_even_nums(arr)
    arr.select { |num| num % 2 == 0}
end

def reject_puppies(arr)
    arr.reject { |puppy| puppy["age"] <= 2 }
end

def count_positive_subarrays(arr)
    arr.count { |arr| arr.inject {|sum, num| sum + num} > 0 }
end

def aba_translate(word)
    vowels = "aeiou"
    new_word = ""
    
    word.each_char do |char|
        if vowels.include?(char)
            new_word += char + 'b' + char
        else
            new_word += char
        end
    end

    new_word
end

def aba_array(arr)
    vowels = "aeiou"

    new_arr = arr.map do |word|
        aba_translate(word)
    end

    new_arr
end