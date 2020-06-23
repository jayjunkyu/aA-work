require "byebug"

def all_words_capitalized?(arr)
    # debugger
    arr.all? {|word| word == word.capitalize}
end

def no_valid_url?(arr)
    endings = ["com", "net", "io", "org"]
    arr.none? {|address| endings.include?(address.split('.')[1])}
end

def any_passing_students?(students)
    students.any? do |student|
        sum = student[:grades].inject { |sum, score| sum + score }
        average = sum / student.length
        average >= 75.0
    end
end

