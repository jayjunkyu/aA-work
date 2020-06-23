require 'byebug'

class Array
    def my_each(&prc)
        self.each { |el| prc.call(el) }
        return self
    end

    def my_select(&prc)
        new_arr = []
        self.each { |el| new_arr << el if prc.call(el) }
        new_arr
    end

    def my_reject(&prc)
        new_arr = []
        self.each { |el| new_arr << el if !prc.call(el) }
        new_arr
    end

    def my_any?(&prc)
        self.each { |el| return true if prc.call(el) }
        false
    end

    def my_all?(&prc)
        self.each { |el| return false if !prc.call(el) }
        true
    end

    def my_flatten(data = self)
        # debugger
        return [data] if !data.is_a?(Array)
        
        flattened = []

        data.each do |el|
            flattened += self.my_flatten(el)
        end

        flattened
    end

    def my_rotate(num = 1)
        new_arr = []
        reverse = false
        reverse = true if num < 0
        count = self.length
        n = self.length

        if !reverse
            start = num % n
            while count > 0
                new_arr << self[start]
                start += 1
                start %= n
                count -= 1
            end
        else
            num *= -1
            start = n - num
            while count > 0
                new_arr << self[start]
                start += 1
                start %= n
                count -= 1
            end
        end

        new_arr
    end

    def my_join(sperator='')
        new_string = ""
        self.each.with_index do |el, i|
            new_string += el.to_s
            new_string += sperator.to_s if i < self.length - 1
        end

        new_string
    end

    def my_reverse
        new_arr = []

        self.reverse_each do |el|
            new_arr << el
        end

        new_arr
    end    
end

# return_value = [1,2,3].my_each { |num| puts num }.my_each { |num| puts num }
# p return_value  # => [1, 2, 3]

# a = [1,2,3]
# a.my_select { |num| num > 1 } # => [2, 3]
# a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]

def factors(num)
    new_arr = []

    (1..num).each do |n|
        new_arr << n if num % n == 0
    end
    
    new_arr
end

# def bubble_sort!(&prc)

# end