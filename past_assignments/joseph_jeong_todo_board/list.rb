require_relative "item"

class List
    attr_reader :items
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, *description)  # using a splat operator here to make description optional
        if description == []
            description = ""
        end

        if !Item.valid_date?(deadline)
            return false
        end

        new_item = Item.new(title, deadline, description[0])
        @items << new_item
        true
    end

    def size
        @items.length
    end

    # we use a instance method because it requires knowledge
    # about a specific List instance
    def valid_index?(index)  
        0 <= index && index < self.size
    end

    def swap(index_1, index_2)  # swaps two elements if valid indices
        if !self.valid_index?(index_1) || !self.valid_index?(index_2)
            return false
        end

        # it is important to note that we are preventing a user
        # from manually manipulating the list in silly ways like
        # adding a non Item instances to the list or having empty entries in the list

        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def priority  # getter for first item
        @items[0]
    end

    def [](index)  # getter for specific item
        if !self.valid_index?(index)
            return false
        end

        @items[index]
    end

    def print(*index)
        if index != []  # if user wants a specific index, print that only
            index = index[0].to_i
            self.print_full_item(index)
            return
        end

        # else, print the whole list
        puts
        puts " ------------------------------------------- "
        len_for_title = (43 - @label.length) / 2
        marks = ""
        while len_for_title > 0
            marks += " "
            len_for_title -= 1
        end
        puts marks + @label + marks
        puts " ------------------------------------------- "
        puts " Index | Item          | Deadline    | Done "
        puts " ------------------------------------------- "

        @items.each.with_index do |item, i|
            item_box = "| #{item.title}"
            
            while item_box.length < 16  # this is to keep uniform length of spaces
                item_box += ' '
            end
            
            done = ' '
            done = 'O' if item.done == true

            puts " #{i}     " + item_box + "| #{item.deadline}  " + "|  [#{done}]"
        end

        puts " ------------------------------------------- "
        puts
    end

    def print_full_item(index)  # prints a specific item based on index
        if !self.valid_index?(index)
            return false
        end
        
        done = ' '
        done = 'O' if @items[index].done == true
        
        puts
        puts " ------------------------------------------- "
        need_this_much = 43 - (@items[index].title.length + @items[index].deadline.length + 4)
        space = ""
        while need_this_much > 0  # this is needed to keep uniform space when displayed
            space += ' '
            need_this_much -= 1
        end
        puts " " + "#{@items[index].title}" + space + "#{@items[index].deadline} [#{done}] "
        puts
        puts " " + "#{@items[index].description}"
        puts " ------------------------------------------- "
        puts
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, amount = 1) # move an element up (default is once)
        if !self.valid_index?(index)
            return false
        end

        while amount > 0
            if index == 0
                break
            end
            self.swap(index, index-1)
            index -= 1
            amount -= 1
        end

        true
    end

    def down(index, amount = 1)  # move an element down (default is once)
        if !self.valid_index?(index)
            return false
        end

        while amount > 0
            if index == self.size - 1
                break
            end
            self.swap(index, index+1)
            index += 1
            amount -= 1
        end

        true
    end

    def sort_by_date!  # sorts by ascending date
        @items.sort_by! { |item| item.deadline.split('-').join.to_i} 
    end

    def toggle_item(index)  # this marks/unmarks if item is done
        @items[index].toggle
    end

    def remove_item(index)  # this removes one item based on index
        if !self.valid_index?(index)
            return false
        end

        @items.delete_at(index)
    end

    def purge # this removes all "done" items
        # we first compile a list of items to delete
        # since when item is deleted, index shifts
        delete_list = []
        @items.each.with_index do |item, i|
            delete_list << item if item.done == true
        end

        # use index to locate index every iteration
        delete_list.each do |del|
            @items.delete_at(@items.index(del))
        end
    end

end