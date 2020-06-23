def average(num_1, num_2)
    (num_1 + num_2) / 2.0
end


def average_array(arr)
    arr.inject { |acc, ele| acc + ele } / (arr.length * 1.0)
end


def repeat(s, num)
    s * num
end


def yell(s)
    s.upcase + "!"
end


def alternating_case(s)
    parts = s.split()
    parts.each.with_index do |word, idx|
        if idx % 2 == 0
            word.upcase!
        else
            word.downcase!
        end
    end

    parts.join(' ')
end