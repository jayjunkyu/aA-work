class Map
    def initialize
        @map = []
    end

    def set(key, value)
        # updating [key, value] -> worst case: O(n)
        # setting [key, value] -> average case: O(1)
        pair_index = map.index { |pair| pair[0] == key }
        if pair_index
            map[pair_index][1] = value
        else
            map.push([key, value])
        end

        value
    end

    def get(key)
        # worst case: O(n)
        # this is not ideal as most hash table implementations have a O(1) average time
        map.each { |pair| return pair[1] if pair[0] == key }
        nil
    end

    def delete(key)
        value = get(key)
        map.reject! { |pair| pair[0] == key }
        value
    end

    def show
        map
    end

    private
    attr_reader :map
end

if __FILE__ == $PROGRAM_NAME
    my_map = Map.new
    my_map.set(24, 'apple')
    my_map.set(24, 'orange')
    my_map.set(8, 'lakers')
    my_map.get(8)
    my_map.delete(24)
    puts my_map.show
end