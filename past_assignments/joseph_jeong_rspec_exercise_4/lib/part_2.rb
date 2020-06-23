def proper_factors(num)
    (1...num).select.each { |factor| num % factor == 0 }
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    aliquot_sum(num) == num
end

def ideal_numbers(n)
    perfect = []
    start = 1
    until n == 0
        if perfect_number?(start)
            perfect << start
            n -= 1
        end
        start += 1
    end

    perfect
end