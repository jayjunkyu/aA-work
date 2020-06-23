# Excercise 2: Write a Queue class!

class Queue
    def initialize
        @queue = Array.new()
    end

    def enqueue(el)
        queue << el
    end

    def dequeue
        # popping the head element
        queue.shift
    end

    def peek
        # this is a singly linked queue
        # so the head is the first element
        queue[0]
    end

    private
    attr_accessor :queue
end

if __FILE__ == $PROGRAM_NAME
    my_queue = Queue.new
    my_queue.enqueue(1)
    my_queue.enqueue(4)
    my_queue.enqueue(2)
    puts my_queue.peek
    my_queue.dequeue
    puts my_queue.peek
end 