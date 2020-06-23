def my_reject(arr, &prc)
    new_arr = []
    arr.each do |el|
        if !prc.call(el)
            new_arr << el
        end
    end

    new_arr
end

def my_one?(arr, &prc)
    count_true = 0
    arr.each do |el|
        if prc.call(el)
            count_true += 1
        end

        if count_true > 1
            return false
        end
    end

    count_true == 1
end

def hash_select(hash, &prc)
    new_hash = {}
    hash.each do |k, v|
        if prc.call(k,v)
            new_hash[k] = v
        end
    end

    new_hash
end

def xor_select(arr, prc_1, prc_2)
    new_arr = []

    arr.each do |el|
        if (prc_1.call(el) && !prc_2.call(el)) || (!prc_1.call(el) && prc_2.call(el))
            new_arr << el
        end
    end

    new_arr
end

def proc_count(value, prcs)
    count_true = 0
    prcs.each do |prc|
        if prc.call(value)
            count_true += 1
        end
    end

    count_true
end