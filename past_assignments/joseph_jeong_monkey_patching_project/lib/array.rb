# Monkey-Patch Ruby's existing Array class to add your own custom methods
require "byebug"

class Array
  def span
    if self.length > 1
        return self.max - self.min
    elsif self.length == 1
        return 0
    else
        return nil
    end
  end

  def average
    if self.empty?
        return nil
    elsif self.all? { |ele| ele.is_a?(Integer) }
        return (self.sum * 1.0) / self.length
    end
  end

  def median
    if self.empty?
        return nil
    end

    copy = self.sort

    if copy.length % 2 == 1
        return copy[copy.length / 2]
    else
        left = copy[copy.length / 2 - 1]
        right = copy[copy.length / 2]
        return (left + right) / 2.0
    end
  end

  def counts
    count = Hash.new(0)

    self.each do |ele|
        count[ele] += 1
    end
    
    count
  end

  def my_count(value)
    hash = self.counts
    hash[value]
  end

  def my_index(value)
    hash = {}

    self.each.with_index do |ele, idx|
        if !hash.keys.include?(ele)
            hash[ele] = idx
        end
    end

    hash[value]
  end

  def my_uniq
    new_arr = []

    self.each do |ele|
        if !new_arr.include?(ele)
            new_arr << ele
        end
    end

    new_arr
  end

  def my_transpose
    new_arr = []
    row = []

    i = 0
    j = 0

    # debugger
    while i < self.length
        while j < self[0].length
            row << self[j][i]
            j += 1
        end
        new_arr << row
        row = []
        i += 1
        j = 0
    end

    new_arr
  end
end


# p [1,2,3].average
# p [1,2,'a'].average
# p [].average