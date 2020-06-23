class Item
    attr_reader :deadline
    attr_accessor :title, :description

    # we use a class method here because valid_date? does not require
    # any knowledge of a specific Item
    def self.valid_date?(date)
        date = date.split('-')

        return false if date.length != 3

        nums = ('0'..'9').to_a
        year = date[0]
        month = date[1]
        day = date[2]
        
        if year.length != 4 || month.length != 2 || day.length != 2
            return false
        end

        if month.to_i > 12 || day.to_i > 31
            return false
        end

        true
    end

    def initialize(title, deadline, description)
        if self.class.valid_date?(deadline)
            @deadline = deadline
        else
            raise "Invalid date. Format: YYYY-MM-DD"
        end
        
        @title = title
        @description = description
        @done = false
    end

    def deadline=(deadline)
        if self.class.valid_date?(deadline)
            @deadline = deadline
        else
            raise "Invalid date. Format: YYYY-MM-DD"
        end
    end

    def toggle
        @done = !@done
    end
    
end

# p Item.valid_date?('2019-10-25') # true
# p Item.valid_date?('1912-06-23') # true
# p Item.valid_date?('2018-13-20') # false
# p Item.valid_date?('2018-12-32') # false
# p Item.valid_date?('10-25-2019') # false

# Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')

# test = Item.new(
#     'Buy Cheese',
#     '2019-10-21',
#     'We require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!'
# )

# Item.new(
#     'Fix checkout page',
#     '10-25-2019',
#     'The font is too small.'
# ) # raises error due to invalid date

# puts test.description