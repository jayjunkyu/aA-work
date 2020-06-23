def zip(*arr)
    n = arr[0].length
    
    rows = n
    cols = 0
    
    arr.each do |ar|
        if ar.length != n
            return false
        end
        cols += 1
    end

    new_2d_arr = Array.new(rows) { Array.new(cols) }

    (0...rows).each do |i|
        (0...cols).each do |j|
            new_2d_arr[i][j] = arr[j][i]
        end
    end

    new_2d_arr
end

def prizz_proc(arr, prc_1, prc_2)
    new_arr = []

    arr.each do |el|
        if (prc_1.call(el) && !prc_2.call(el)) || (!prc_1.call(el) && prc_2.call(el))
            new_arr << el
        end
    end

    new_arr
end

def zany_zip(*arr)
    rows = 0
    cols = 0

    arr.each do |ar|
        if ar.length > rows
            rows = ar.length
        end
        cols += 1
    end

    new_2d_arr = Array.new(rows) { Array.new(cols) }

    (0...rows).each do |i|
        (0...cols).each do |j|
            new_2d_arr[i][j] = arr[j][i]
        end
    end

    new_2d_arr
end

def maximum(arr, &prc)    
    largest = arr[0]

    (1...arr.length).each do |i|
        if prc.call(arr[i]) >= prc.call(largest)
            largest = arr[i]
        end
    end

    largest
end

def my_group_by(arr, &prc)
    hash = Hash.new { |h, k| h[k] = [] }
    
    arr.each do |el|
        hash[prc.call(el)] << el
    end

    hash
end

def max_tie_breaker(arr, prc_1, &prc_2)
    return nil if arr.empty?
    
    largest = arr[0]
    ties = []
    is_tie = false

    # calling block to determine largest
    # if ties exist store them in ties
    (1...arr.length).each do |i|
        if prc_2.call(arr[i]) > prc_2.call(largest)
            largest = arr[i]
            is_tie = false
        elsif prc_2.call(arr[i]) == prc_2.call(largest)
            is_tie = true
            ties << largest if !ties.include?(largest)
            ties << arr[i] if !ties.include?(arr[i])
        end
    end

    # if tied use proc to determine largest
    # if not tied return largest
    if is_tie
        (1...ties.length).each do |i|
            if prc_1.call(ties[i-1]) > prc_1.call(ties)
                largest = ties[i-1]
                is_tie = false
            elsif prc_1.call(ties[i-1]) < prc_1.call(ties)
                largest = ties[i]
                is_tie = false
            else
                is_tie = true
            end
        end
    else
        return largest
    end

    ties[0]  # if still tied return first element in arr
end

def silly_syllables(sentence)
    words = sentence.split()    

    words.each.with_index do |word, i|
        if !less_than_2_vowels?(word)  # if vowels > 2
            # remove char outside first and last vowels
            new_word = keep_bt_vowels(word)
            words[i] = new_word
        end
    end

    words.join(" ")
end

def less_than_2_vowels?(word)
    vowels = "aeiou"
    count = 0
    word.each_char do |char|
        if vowels.include?(char)
            count += 1
        end
    end
    
    count < 2
end

def keep_bt_vowels(word)
    vowels = "aeiou"
    first = 0
    last = 0

    # detect fist vwoel index and break
    (0...word.length).each do |i|
        if vowels.include?(word[i])
            first = i
            break
        end
    end

    # detect last vowel index and break
    (0...word.length).reverse_each do |i|
        if vowels.include?(word[i])
            last = i
            break
        end
    end

    word[first..last]
end