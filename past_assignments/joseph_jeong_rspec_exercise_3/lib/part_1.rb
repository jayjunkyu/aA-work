def is_prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).none? { |factor| num % factor == 0 }
end

def nth_prime(num)
    return 2 if num == 1

    i = num
    start_num = 3
    nth_prime = 3
    while i > 1
        if is_prime?(start_num)
            nth_prime = start_num
            i -= 1
        end
        start_num += 1
    end

    nth_prime
end

def prime_range(min, max)
    primes = []

    (min..max).each do |num|
        if is_prime?(num)
            primes << num
        end
    end

    primes
end