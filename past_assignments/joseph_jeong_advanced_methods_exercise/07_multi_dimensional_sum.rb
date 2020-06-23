# Write a method, multi_dimensional_sum(array), that accepts a multidimensional array as an arg 
# and returns the sum of all numbers in the array.

def multi_dimensional_sum(array)    
    """
    time complexity: O(n)
    space complexity: O(n) -> max n recursive stack calls, ex) array = [[1], [2], [3], [4]]
    """

    # def depth(array)
    #     if array == array.flatten
    #         return array
    #     else
    #         depth(array.flatten)
    #     end
    # end

    # new_arr = depth(array)

    # new_arr.sum
    array.flatten.sum
end


arr_1 = [
    [4, 3, 1],
    [8, 1],
    [2]
]

p multi_dimensional_sum(arr_1)    # => 19

arr_2 = [
    [ [3, 6], [7] ],
    [ [5, 2], 1 ]
]

p multi_dimensional_sum(arr_2)    # => 24