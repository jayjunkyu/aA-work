# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

# def compress_str(str)
#     """
#     time complexity: O(n)
#     space complexity: O(n)
#     """

#     temp = str[0]
#     parts = []
#     compressed = ""

#     # splitting string by duplicates
#     (1...str.length).each do |idx|
#         if temp[0] == str[idx]  # add char to temp if duplicate
#             temp += str[idx]
#         else
#             parts << temp  # if not add duplicate to list and change temp to new char
#             temp = str[idx]
#         end
#     end

#     parts << temp  # add leftovers

#     parts.each do |part|
#         if part.length == 1  # if length is 1 add just the character to compressed
#             compressed += part
#         else  # else add the length and a single character to compressed
#             compressed += part.length.to_s + part[0]
#         end
#     end

#     compressed
# end

def compress_str(str)
    compressed = ""

    i = 0
    while i < str.length
        char = str[i]
        count = 0

        while char == str[i]
            count += 1
            i += 1
        end

        if count == 1
            compressed += char
        else
            compressed += count.to_s + char
        end
    end

    compressed
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
