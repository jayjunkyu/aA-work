require "byebug"

# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    if num_1 > num_2
        num_1, num_2 = num_2, num_1
    end

    multiple = 1
    until multiple * num_1 % num_2 == 0
        multiple += 1
    end

    num_1 * multiple
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigrams = Hash.new(0)
    most_freq = 0
    freq_bigram = ""

    (0..str.length-2).each do |i|
        bigrams[str[i..i+1]] += 1

        if bigrams[str[i..i+1]] > most_freq
            most_freq = bigrams[str[i..i+1]]
            freq_bigram = str[i..i+1]
        end
    end

    freq_bigram
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        reversed = {}

        self.each do |k, v|
            reversed[v] = k
        end

        reversed
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        num_hash = {}
        count_pairs = 0
        self.each.with_index do |ele, i|
            target = num - ele
            if num_hash.has_key?(target)
                count_pairs += 1
            else
                num_hash[ele] = i
            end
        end

        count_pairs
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)
        # debugger
        prc ||= Proc.new { |a, b| (a <=> b) }

        sorted = false

        while !sorted
            sorted = true
            (0...self.length-1).each do |i|
                if prc.call(self[i], self[i+1]) == 1
                    sorted = false
                    self[i], self[i+1] = self[i+1], self[i]
                end
            end
        end

        self
    end
end
