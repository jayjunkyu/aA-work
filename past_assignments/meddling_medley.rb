require "byebug"

def duos(s)
    count_duos = 0
    (0...s.length-1).each do |i|
        count_duos += 1 if s[i] == s[i+1]
    end

    count_duos
end

# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0

def sentence_swap(sentence, hash)
    words = sentence.split()

    words.each.with_index do |word, i|
        words[i] = hash[word] if hash.has_key?(word)
    end

    words.join(' ')
end

# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'

# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'

# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'

def hash_mapped(hash, prc_1, &prc_2)
    new_hash = {}
    hash.each_key do |key|
        new_hash[prc_2.call(key)] = prc_1.call(hash[key])
    end

    new_hash
end

# double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# # {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

# first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# # {25=>"q", 36=>"w"}

def counted_characters(s)
    count = Hash.new(0)
    result = []
    # debugger
    s.each_char do |char|
        count[char] += 1
        if count[char] > 2 && !result.include?(char)
            result << char
        end
    end

    result
end

# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []

def triplet_true?(s)
    if s.length < 3
        return false
    end

    (0...s.length-2).each do |i|
        if s[i] == s[i+1] && s[i] == s[i+2]
            return true
        end
    end

    false
end

# p triplet_true?('caaabb')        # true
# p triplet_true?('terrrrrible')   # true
# p triplet_true?('runninggg')     # true
# p triplet_true?('bootcamp')      # false
# p triplet_true?('e')             # false

def energetic_encoding(s, hash)
    new_string = ""
    s.each_char do |char|
        if hash.has_key?(char)
            new_string += hash[char]
        elsif char == ' '
            new_string += char
        else
            new_string += "?"
        end
    end

    new_string
end

# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'

# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'

# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'

# p energetic_encoding('bike', {}) # '????'

def uncompress(s)
    # debugger
    new_string = ""
    (0..s.length-1).each do |i|
        count = s[i+1].to_i
        while count > 0
            new_string += s[i]
            count -= 1
        end
    end

    new_string
end

# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

def conjunct_select(arr, *prcs)
    new_arr = []

    arr.each do |el|
        new_arr << el if prcs.all? { |prc| prc.call(el) }
    end

    new_arr
end

# is_positive = Proc.new { |n| n > 0 }
# is_odd = Proc.new { |n| n.odd? }
# less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def add_ay(word)
    new_word = ""

    (0...word.length).each do |i|
        if "aeiou".include?(word[i].downcase) && word[0].upcase == word[0]
            return (word[i..-1].capitalize + word[0...i].downcase + "ay")
        elsif "aeiou".include?(word[i].downcase)
            return (word[i..-1].downcase + word[0...i].downcase + "ay")
        end
    end
end


def convert_pig_latin(sentence)
    words = sentence.split()

    (0...words.length).each do |i|
        next if words[i].length < 3
        if "aeiou".include?(words[i][0].downcase)
            words[i] += 'yay'
        else
            words[i] = add_ay(words[i])
            words[i].capitalize! if i == 0
        end 
    end

    words.join(' ')
end

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverberate(sentence)
    words = sentence.split()
    (0...words.length).each do |i|
        new_word = ""
        next if words[i].length < 3
        if "aeiou".include?(words[i][-1])
            new_word = (words[i] + words[i]).downcase
            if words[i] == words[i].capitalize
                new_word.capitalize!
                words[i] = new_word
            end
            words[i] = new_word
        else
            (0...words[i].length).each do |j|
                if "aeiou".include?(words[i][j])
                    new_word = (words[i] + words[i][j..-1]).downcase
                    if words[i] == words[i].capitalize
                        new_word.capitalize!
                    end
                end
            end
            words[i] = new_word
        end
    end

    words.join(' ')
end

# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
    new_arr = []

    arr.each do |el|
        prcs.each do |prc|
            new_arr << el if prc.call(el)
        end
    end

    new_arr
end

# longer_four = Proc.new { |s| s.length > 4 }
# contains_o = Proc.new { |s| s.include?('o') }
# starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]

# helper method to find first vowel
def remove_first_vowel(word)
    (0...word.length).each do |i|
        return word[0...i] + word[i+1..-1] if "aeiou".include?(word[i])
    end
end

# helper method to find last vowel
def remove_last_vowel(word)
    (0...word.length).reverse_each do |i|
        return word[0...i] + word[i+1..-1] if "aeiou".include?(word[i])
    end
end

# helper method to determine if vowel exists in word
def has_vowel?(word)
    vowels = "aeiou"

    word.each_char do |char|
        return true if vowels.include?(char)
    end

    false
end

def alternating_vowel(sentence)
    # debugger
    new_sentence = ""
    words = sentence.split()
    change_first_vowel = true

    words.each do |word|
        if has_vowel?(word) && change_first_vowel
            new_sentence += remove_first_vowel(word) + " "
        elsif has_vowel?(word) && !change_first_vowel
            new_sentence += remove_last_vowel(word) + " "
        else
            new_sentence += word + " "
        end

        change_first_vowel = !change_first_vowel
    end

    new_sentence.strip
end

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def end_with_vowel?(word)
    "aeiou".include?(word[-1])
end

def add_b(word)
    new_word = ""
    word.each_char do |char|
        if "aeiou".include?(char.downcase)
            new_word += char + "b" + char
        else
            new_word += char
        end
    end

    new_word
end



def silly_talk(sentence)
    new_sentence = ""
    words = sentence.split()

    words.each do |word|
        if end_with_vowel?(word)
            new_word = word + word[-1] + " "
            new_word.capitalize! if word == word.capitalize
            new_sentence += new_word
        else
            new_word = add_b(word) + " "
            new_word.capitalize! if word == word.capitalize
            new_sentence += new_word
        end
    end

    new_sentence.strip
end

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(s)
    # debugger
    new_string = ""
    consecutive = 1
    curr_char = s[0]

    (0...s.length).each do |i|
        # case where 1 char left
        if i == s.length-1 && consecutive == 1
            new_string += s[i]
        # case where last char had consecutive chars
        elsif i == s.length-1 && consecutive > 1
            new_string += s[i] + consecutive.to_s
        # case where consecutive char is in the middle of string
        elsif s[i] == s[i+1]
            consecutive += 1
        # case where the streak ended and need to update new current
        else
            if consecutive > 1
                new_string += curr_char + consecutive.to_s 
            elsif consecutive == 1
                new_string += curr_char
            end
            curr_char = s[i+1]
            consecutive = 1
        end
    end

    new_string
end

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"