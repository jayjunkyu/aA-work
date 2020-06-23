require 'byebug'

def range_recursive(start, final)
    return [] if final < start
    return [start] if final - start == 1
    [start] + range_recursive(start+1, final)
end

def range_iterative(start, final)
    result = []
    (start...final).each do |num|
        result << num
    end

    result
end

def exponentiation_1(base, exponent)
    return 1 if exponent == 0
    return base if exponent == 1

    base * exponentiation(base, exponent-1)
end


def exponentiation_2(b, n)
    return 1 if n == 0
    return b if n == 1

    if n % 2 == 0
        return exponentiation_2(b, n/2) ** 2
    else
        return b * (exponentiation_2(b, (n-1)/2) ** 2)
    end
end


class Array
    def deep_dup
        new_array = []
        self.each do |el|
          new_array << (el.is_a?(Array) ? el.deep_dup : el)
        end
        new_array
    end

    def subsets
        subsets = []
        generate_subsets(0, self, [], subsets)
        return subsets
    end

    private
    def generate_subsets(index, arr, current, subsets)
        subsets.append(current.dup)

        (index...arr.length).each do |i|
            current.append(arr[i])
            generate_subsets(i+1, arr, current, subsets)
            current.pop()
        end
    end
end

def fibonacci(n)
    return n if n <= 1

    fibonacci(n-1) + fibonacci(n-2)
end


def bsearch(array, target)
    head = 0
    tail = array.length - 1
    while head <= tail
        mid = (head+tail) / 2
        if array[mid] > target
            tail = mid - 1
        elsif array[mid] == target
            return mid
        else
            head = mid + 1
        end
    end

    nil
end

def merge_sort(arr)
    if arr.length  > 1
        mid = arr.length / 2
        left = arr[0...mid]
        right = arr[mid..-1]
        merge_sort(left)
        merge_sort(right)

        i = 0
        j = 0
        k = 0

        while i < left.length && j < right.length
            if left[i] < right[j]
                arr[k] = left[i]
                i += 1
                k += 1
            else
                arr[k] = right[j]
                j += 1
                k += 1
            end
        end

        while i < left.length
            arr[k] = left[i]
            i += 1
            k += 1
        end

        while j < right.length
            arr[k] = right[j]
            j += 1
            k += 1
        end

        return arr
    end
end

def permutations(arr)
    if arr.length == 0
        return []
    elsif arr.length == 1
        return [arr]
    else
        result = []
        (0...arr.length).each do |i|
            prefix = arr[i]
            remainder = arr[0...i] + arr[i+1..-1]
            permutations(remainder).each do |rem|
                result.append([prefix] + rem)
            end
        end
        return result
    end
end


def greedy_make_change(amount, coins = [25,10,5,1])
    # debugger
    coins.sort.
        reverse.
        map{|coin| f = amount/coin; amount %= coin; Array.new(f){coin} }.
        flatten
end

def make_change(target, coins=[25,10,5,1])
    """
    This is essentially a "Combination Sum I" problem from Leetcode.
    1. Generate all combinations including duplicates that matches the target.
    2. Return the shortest combination of all combinations generated.
    """
    return [] if target == 0
    return nil if coins.none? { |coin| coin <= target }
    coins = coins.sort.reverse

    best_change = nil
    coins.each_with_index do |coin, index|
        next if coin > target
        remainder = target - coin
        best_remainder = make_change(remainder, coins.drop(index))
        next if best_remainder.nil?
        this_change = [coin] + best_remainder
        if best_change.nil? || (this_change.count < best_change.count)
            best_change = this_change
        end
    end

    best_change
end

p make_change(24, [10,7,1])