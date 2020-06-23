def reverser(s, &prc)
    prc.call(s.reverse)
end


def word_changer(sentence, &prc)
    new_sentence = []
    words = sentence.split(' ')

    words.each { |word| new_sentence << prc.call(word)}

    new_sentence.join(' ')
end


def greater_proc_value(num, prc_1, prc_2)
    result_1 = prc_1.call(num)
    result_2 = prc_2.call(num)

    result_1 > result_2 ? result_1 : result_2
end


def and_selector(arr, prc_1, prc_2)
    new_arr = []

    arr.each { |ele| new_arr << ele if prc_1.call(ele) && prc_2.call(ele) == true }

    new_arr
end


def alternating_mapper(arr, prc_1, prc_2)
    new_arr = []

    arr.each.with_index { |ele, i| i % 2 == 0 ? new_arr << prc_1.call(ele) :  new_arr << prc_2.call(ele)}

    new_arr
end