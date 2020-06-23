# Reimplement the bubble sort outlined in the preceding lecture.
# The bubble_sort method should accept an array of numbers and arrange the elements in increasing order.
# The method should return the array.
# Do not use the built-in Array#sort

def bubble_sort(arr)
    """
    time complexity: O(n^2)
    space complexity: O(1)
    """

    sorted = false  # boolean flag for not being sorted

    while !sorted
        sorted = true  # switch flag to true

        (0...arr.length-1).each do |idx|
            if arr[idx] > arr[idx+1]  # flag switches back to false if loop detects unsorted elements
                arr[idx], arr[idx+1] = arr[idx+1], arr[idx]
                sorted = false
            end
        end
    end

    arr
end


p bubble_sort([2, 8, 5, 2, 6])      # => [2, 2, 5, 6, 8]
p bubble_sort([10, 8, 7, 1, 2, 3])  # => [1, 2, 3, 7, 8, 10]