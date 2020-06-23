require "byebug"

def strange_sums(arr)
    # debugger
    zero_pairs = 0
    num_hash = {}

    arr.each.with_index do |num, i|
        target = -num
        if num_hash.has_key?(target)
            zero_pairs += 1
        end
        num_hash[num] = i
    end

    zero_pairs
end

# p strange_sums([2, -3, 3, 4, -2])     # 2
# p strange_sums([42, 3, -1, -42])      # 1
# p strange_sums([-5, 5])               # 1
# p strange_sums([19, 6, -3, -20])      # 0
# p strange_sums([9])                   # 0

def pair_product(arr, prod)
    (0...arr.length).each do |i|
        (i+1...arr.length).each do |j|
            if arr[i] * arr[j] == prod
                return true
            end
        end
    end

    false
end

# p pair_product([4, 2, 5, 8], 16)    # true
# p pair_product([8, 1, 9, 3], 8)     # true
# p pair_product([3, 4], 12)          # true
# p pair_product([3, 4, 6, 2, 5], 12) # true
# p pair_product([4, 2, 5, 7], 16)    # false
# p pair_product([8, 4, 9, 3], 8)     # false
# p pair_product([3], 12)             # false

def rampant_repeats(str, hash)
    new_str = ""
    str.each_char do |char|
        if hash.has_key?(char)
            new_str += char * hash[char]
        else
            new_str += char
        end
    end

    new_str
end

# p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
# p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
# p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
# p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'

def perfect_square?(num)
    Math.sqrt(num) * Math.sqrt(num) == num
end

# p perfect_square?(1)     # true
# p perfect_square?(4)     # true
# p perfect_square?(64)    # true
# p perfect_square?(100)   # true
# p perfect_square?(169)   # true
# p perfect_square?(2)     # false
# p perfect_square?(40)    # false
# p perfect_square?(32)    # false
# p perfect_square?(50)    # false

def num_of_divisors(num)
    count = 0

    (1...num).each do |divisor|
        if num % divisor == 0
            count += 1
        end
    end

    count
end

def anti_prime?(num)
    divisors = num_of_divisors(num)

    (1...num).each do |n|
        if num_of_divisors(n) > divisors
            return false
        end
    end

    true
end

# p anti_prime?(24)   # true
# p anti_prime?(36)   # true
# p anti_prime?(48)   # true
# p anti_prime?(360)  # true
# p anti_prime?(1260) # true
# p anti_prime?(27)   # false
# p anti_prime?(5)    # false
# p anti_prime?(100)  # false
# p anti_prime?(136)  # false
# p anti_prime?(1024) # false

def matrix_addition(matrix_1, matrix_2)
    new_matrix = Array.new(matrix_1.length) { Array.new(matrix_1[0].length)}
    (0...matrix_1.length).each do |i|
        (0...matrix_1[0].length).each do |j|
            new_matrix[i][j] = matrix_1[i][j] + matrix_2[i][j]
        end
    end

    new_matrix
end

matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
# p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
# p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
# p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]

def mutual_factors(*nums)
    smallest = nums.min
    mutual = []

    (1..smallest).each do |factor|
        if nums.all? { |n| n % factor == 0 }
            mutual << factor
        end
    end

    mutual
end

# p mutual_factors(50, 30)            # [1, 2, 5, 10]
# p mutual_factors(50, 30, 45, 105)   # [1, 5]
# p mutual_factors(8, 4)              # [1, 2, 4]
# p mutual_factors(8, 4, 10)          # [1, 2]
# p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
# p mutual_factors(12, 24, 64)        # [1, 2, 4]
# p mutual_factors(22, 44)            # [1, 2, 11, 22]
# p mutual_factors(22, 44, 11)        # [1, 11]
# p mutual_factors(7)                 # [1, 7]
# p mutual_factors(7, 9)              # [1]

def tribonacci_number(n)
    return 1 if n <= 2
    return 2 if n == 3

    tribonacci_number(n-1) + tribonacci_number(n-2) + tribonacci_number(n-3)
end

# p tribonacci_number(1)  # 1
# p tribonacci_number(2)  # 1
# p tribonacci_number(3)  # 2
# p tribonacci_number(4)  # 4
# p tribonacci_number(5)  # 7
# p tribonacci_number(6)  # 13
# p tribonacci_number(7)  # 24
# p tribonacci_number(11) # 274

def matrix_addition_reloaded(*matrices)
    n = matrices.length
    rows = matrices[0].length
    cols = matrices[0][0].length

    return nil if !matrices.all? { |matrix| matrix.length == rows && matrix[0].length == cols }

    new_matrix = Array.new(rows) { Array.new(cols, 0) }
    
    (0...n).each do |i|
        (0...rows).each do |j|
            (0...cols).each do |k|
                new_matrix[j][k] += matrices[i][j][k]
            end
        end
    end

    new_matrix
end

# matrix_a = [[2,5], [4,7]]
# matrix_b = [[9,1], [3,0]]
# matrix_c = [[-1,0], [0,-1]]
# matrix_d = [[2, -5], [7, 10], [0, 1]]
# matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
# p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
# p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
# p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil

def squarocol?(matrix)
    n = matrix.length
    
    # checking rows
    (0...n).each do |i|
        count_same = 1
        (1...n).each do |j|
            if matrix[i][j] == matrix[i][j-1]
                count_same += 1
            end
            return true if count_same == n
        end
    end

    # checking cols
    (0...n).each do |j|
        count_same = 1
        (1...n).each do |i|
            if matrix[i][j] == matrix[i-1][j]
                count_same += 1
            end
            return true if count_same == n
        end
    end
    
    false
end

# p squarocol?([
#     [:a, :x , :d],
#     [:b, :x , :e],
#     [:c, :x , :f],
# ]) # true

# p squarocol?([
#     [:x, :y, :x],
#     [:x, :z, :x],
#     [:o, :o, :o],
# ]) # true

# p squarocol?([
#     [:o, :x , :o],
#     [:x, :o , :x],
#     [:o, :x , :o],
# ]) # false

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 7],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # true

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 0],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # false

def squaragonal?(matrix)
    n = matrix.length

    count_same = 1
    (1...n).each do |i|
        count_same += 1 if matrix[i][i]  == matrix[i-1][i-1]
        return true if count_same == n
    end

    count_same = 1
    (1...n).each do |i|
        count_same += 1 if matrix[i][n-1-i] == matrix[i-1][n-i]
        return true if count_same == n
    end

    false
end

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :x, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :o, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 7],
#     [1, 1, 6, 7],
#     [0, 5, 1, 7],
#     [4, 2, 9, 1],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 5],
#     [1, 6, 5, 0],
#     [0, 2, 2, 7],
#     [5, 2, 9, 7],
# ]) # false

def pascals_triangle(n)
    # debugger
    triangle = []
    prev_layer = []

    (1..n).each do |layer|
        if layer == 1
            triangle << [1]
            next
        end

        if layer == 2
            triangle << [1, 1]
            prev_layer = triangle[-1]
            next
        end

        cur_layer = Array.new(layer, 1)

        (1...prev_layer.length).each do |i|
            cur_layer[i] = prev_layer[i-1] + prev_layer[i]
        end

        triangle << cur_layer
        prev_layer = cur_layer
    end

    triangle
end

# p pascals_triangle(1)
# p pascals_triangle(2)
# p pascals_triangle(3)
# p pascals_triangle(4)
# p pascals_triangle(5)
# p pascals_triangle(7)

def is_prime?(num)
    return false if num < 2

    (2..Math.sqrt(num)).each do |factor|
        return false if num % factor == 0
    end

    true
end

def is_2_pwr_minus_1?(num)
    i = 0

    while 2**i - 1 <= num
        return true if 2**i-1 == num
        i += 1
    end

    false
end


def mersenne_prime(n)
    #debugger
    start = 3
    result = 0
    until n == 0
        if is_prime?(start) && is_2_pwr_minus_1?(start)
            n -= 1
            result = start
        end
        start += 1
    end

    result
end

# p mersenne_prime(6)  #131071

def triangular_word?(word)
    n = word.length
    trian_sum = (n * (n + 1)) / 2
    word_sum = 0

    word.each_char do |char|
        curr_num = (char.ord - 'a'.ord) + 1
        word_sum += curr_num
    end

    p word_sum
    # p trian_sum
    word_sum == trian_sum
end

# p triangular_word?('abc')       # true
# # p triangular_word?('ba')        # true
#-------------CHECK SOLUTION FOR THESE TWO CAES----------------------
# p triangular_word?('lovely')    # true??
# p triangular_word?('question')  # true??
#-------------CHECK SOLUTION FOR THESE TWO CAES----------------------
# # p triangular_word?('aa')        # false
# # p triangular_word?('cd')        # false
# p triangular_word?('cat')       # false
# # p triangular_word?('sink')      # false

def consecutive_collapse(arr)
    i = 0
    while i < arr.length-1
        if (arr[i] - arr[i+1]).abs != 1
            i += 1
        else
            arr.delete_at(i)
            arr.delete_at(i)
            i = 0
        end
    end
    
    arr
end

# p consecutive_collapse([3, 4, 1])                     # [1]
# p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
# p consecutive_collapse([9, 8, 2])                     # [2]
# p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
# p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
# p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
# p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
# p consecutive_collapse([13, 11, 12, 12])              # []

def get_primes(num, n)
    result = []

    (0..num).each do |n|
        result << n if is_prime?(n)
    end

    if n >= -1
        next_primes = 0
        search = num + 1
        until next_primes == n.abs
            if is_prime?(search)
                result << search
                next_primes += 1
            end
            search += 1
        end
    end
    
    result
end

# def pretentious_primes(arr, n)
#     max_num = arr.max
#     primes_list = get_primes(max_num, n)
#     new_arr = Array.new(arr.length)
    
#     # debugger
#     # [2, 3, 5, 7, 11, 13, 17]
#     arr.each.with_index do |num, i|
#         if n > 0
#             (0...primes_list.length-1).each do |j|
#                 if primes_list[j] <= num && num < primes_list[j+1]
#                     new_arr[i] = primes_list[j+n]
#                     break
#                 end
#             end
#         else
#             (0...primes_list.length-1).each do |j|
#                 if primes_list[j] <= num && num <= primes_list[j+1]
#                     new_arr[i] = primes_list[j+n+1]
#                     break
#                 end
#             end

#         end
#     end

#     new_arr
# end

p pretentious_primes([4, 15, 7], 1) # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]