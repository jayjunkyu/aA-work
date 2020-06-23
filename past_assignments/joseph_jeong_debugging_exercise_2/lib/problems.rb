# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require "byebug"

def largest_prime_factor(num)
    if num <= 2
        return num
    end

    (3..num).reverse_each do |factor|
        if num % factor == 0 && is_prime?(factor)
            return factor
        end
    end
end

def is_prime?(num)
    if num < 2
        return true
    end

    (2...Math.sqrt(num)+1).each do |factor|
        if num % factor == 0
            return false
        end
    end

    true
end

def unique_chars?(s)
    count = Hash.new(0)

    s.each_char do |char|
        count[char] += 1
        if count[char] >= 2
            return false
        end
    end

    true
end

def dupe_indices(arr)
    repeated = Hash.new []

    arr.each.with_index do |ele, i|
        # debugger
        repeated[ele] += [i]
    end

    repeated.select do |key|
        # debugger
        if repeated[key].length < 2
            repeated.delete(key)
        end
    end

    repeated
end

def ana_array(arr_1, arr_2)
    if arr_1.length != arr_2.length
        return false
    end

    hash_1 = Hash.new(0)
    hash_2 = Hash.new(0)

    arr_1.each do |ele|
        hash_1[ele] += 1
    end

    arr_2.each do |ele|
        hash_2[ele] += 1
    end

    hash_1 == hash_2
end
