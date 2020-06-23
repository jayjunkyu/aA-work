# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.

def coprime?(num_1, num_2)
    """
    time complexity: O(2 * sqrt(n)) ~= O(sqrt(n))
    space complexity: O(n)
    """
    
    if num_1 == 0 || num_2 == 0
        return false
    end
    
    factors_1 = []
    factors_2 = []
    
    (1..Math.sqrt(num_1)).each do |factor|
        if num_1 % factor == 0
            factors_1 << factor
        end
    end
    
    (1..Math.sqrt(num_2)).each do |factor|
        if num_2 % factor == 0
            factors_2 << factor
        end
    end

    if factors_1.length > factors_2.length
        factors_1, factors_2 = factors_2, factors_1
    end

    count_common = 0
    factors_1.each do |factor|
        if factors_2.include?(factor)
            count_common += 1
        end
    end

    count_common == 1 ? true : false
end

# def coprime?(num_1, num_2)
#     (2..num_2).none? { |factor| num_1 % factor == 0 && num_2 % factor == 0 }
# end


p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false