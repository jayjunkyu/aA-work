def partition(arr, arg)
    arr_1 = []
    arr_2 = []

    arr.each do |num|
        if num < arg
            arr_1 << num
        else
            arr_2 << num
        end
    end

    [arr_1, arr_2]
end


def merge(hash_1, hash_2)
    new_hash = {}

    hash_1.each do |k, v|
        new_hash[k] = v
    end

    hash_2.each do |k, v|
        if !hash_1.key(k)
            new_hash[k] = v
        end
    end

    new_hash
end


def censor(sentence, args)
    vowels = "aeiou"
    sentence = sentence.split()

    sentence.each.with_index do |word, i|
        if args.include?(word.downcase)
            word.each_char.with_index do |char, j|
                if vowels.include?(char.downcase)
                    word[j] = "*"
                end
            end
        end
    end

    sentence.join(' ')
end


def power_of_two?(arg)
    while arg > 1
        arg /= 2.0
    end

    true ? arg == 1 : false
end