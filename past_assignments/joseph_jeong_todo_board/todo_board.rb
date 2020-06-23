require_relative "list"
require_relative "item"

class ToDoBoard
    # users are setting the lists and items during runtime
    # when the run method is executed
    def initialize
        @lists = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')
        case cmd
        when 'mklist'
            label = args[0]
            @lists[label] = List.new(label)
        when 'ls'
            @lists.each_key do |label|
                puts label
            end
        when 'showall'
            @lists.each_value do |list|
                list.print
            end
        when 'mktodo'
            label = args[0]
            args = args[1..-1]
            @lists[label].add_item(*args)
        when 'up'
            label = args[0]
            index = args[1].to_i
            if args.length == 3
                amount = args[1].to_i
            else
                amount = 1
            end
            @lists[label].up(index, amount)
        when 'down'
            label = args[0]
            index = args[1].to_i
            if args.length == 3
                amount = args[1].to_i
            else
                amount = 1
            end
            @lists[label].down(index, amount)
        when 'swap'
            label = args[0]
            index_1 = args[1].to_i
            index_2 = args[2].to_i
            @lists[label].swap(index_1, index_2)
        when 'sort'
            args[0] = label
            @lists[label].sort_by_date!
        when'priority'
            args[0] = label
            @lists[label].print_priority
        when 'print'
            label = args[0]
            args = args[1..-1]
            @lists[label].print(*args)
        when 'toggle'
            label = args[0]
            index = args[1].to_i
            @lists[label].toggle_item(index)
        when 'remove'
            label = args[0]
            index = args[1].to_i
            @lists[label].remove_item(index)
        when 'purge'
            label = args[0]
            @lists[label].purge
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end

        true
    end

    def run
        flag = true
        until flag == false
            flag = self.get_command
        end
    end
end