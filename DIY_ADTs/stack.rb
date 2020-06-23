# Excercise 1: Write a Stack class!
class Stack
    def initialize
        @stack = Array.new()
    end

    def push(el)
        # pushes an element
        stack << el
    end

    def pop
        # removes top element
        stack.pop
    end

    def peek
        # returns top element
        stack[-1]
    end

    private
    attr_accessor :stack
end

# Excercise 2: Write a Queue class!

class Queue
    
end

if __FILE__ == $PROGRAM_NAME
    my_stack = Stack.new()
    my_stack.push(1)
    my_stack.push(5)
    my_stack.push(3)
    my_stack.pop
    puts my_stack.peek
end