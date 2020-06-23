def palindrome?(s)
    s.each_char.with_index do |char, i|
        if s[i] != s[s.length-1-i]
            return false
        end
    end

    true
end


def substrings(s)
    arr = []

    (0...s.length).each do |i|
        (i...s.length).each do |j|
            arr << s[i...j+1]
        end
    end

    arr    
end


def palindrome_substrings(s)
    arr = substrings(s)
    result = []

    arr.each do |word|
        if palindrome?(word) && !result.include?(word) && word.length > 1
            result << word
        end
    end

    result
end