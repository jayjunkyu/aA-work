require "byebug"

def factors(num)
    new_arr = []
    
    (1..num).each do |n|
        new_arr << n if num % n == 0
    end

    new_arr
end

def subwords(string, arr)
    new_arr = []
    substrings = []

    (0...string.length).each do |i|
        (i...string.length).each do |j|
            substrings << string[i..j]
        end
    end

    substrings.each do |sub|
        new_arr << sub if arr.include?(sub) && !new_arr.include?(sub)
    end

    new_arr
end

def doubler(arr)
    new_arr = []

    arr.each do |el|
        new_arr << el * 2
    end

    new_arr
end

class Array
    def bubble_sort!(&prc)
        return self if self.empty? || self.length == 1

        prc ||= Proc.new { |a, b| 1 if a > b }
        sorted = false

        while !sorted
            sorted = true
            (1...self.length).each do |i|
                if prc.call(self[i-1], self[i]) == 1
                    sorted = false
                    self[i-1], self[i] = self[i], self[i-1]
                end
            end
        end
        self
    end

    def bubble_sort(&prc)
        sorted = []
        self.each { |el| sorted << el }
        sorted = sorted.bubble_sort!(&prc)
        sorted
    end

    def my_each(&prc)
        self.length.times do |i|
            prc.call(self[i])
        end

        self
    end

    def my_map(&prc)
        new_arr = []

        self.length.times do |i|
            new_arr << prc.call(self[i])
        end

        new_arr
    end

    def my_select(&prc)
        new_arr = []
        self.length.times do |i|
            new_arr << self[i] if prc.call(self[i])
        end

        new_arr
    end

    def my_inject(acc=self[0], &prc)
        new_arr = []

        if acc == self[0]
            (1...self.length).each do |i|
                acc = prc.call(acc, self[i])
                new_arr << acc
            end
        else
            (0...self.length).each do |i|
                acc = prc.call(acc, self[i])
                new_arr << acc
            end
        end
    
        new_arr
    end
end

def concatenate(arr)
    arr.inject(:+)
end