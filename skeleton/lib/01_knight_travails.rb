require 'set'
require_relative '00_tree_node'
require 'byebug'


class KnightPathFinder
    attr_reader :root_node

    # possible moves of a knight on a chessboard
    MOVES = [
        [-2, 1],
        [-2, -1],
        [-1, -2],
        [-1, 2],
        [2, 1],
        [2, -1],
        [1, 2],
        [1, -2]
    ].freeze

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @visited = Set.new()
        @visited.add(start_pos)
        build_move_tree(@root_node)
    end

    def build_move_tree(node)  # building all possible subsequence moves from start_pos
        queue = [node]  # using a queue do build a tree in a BFS manner

        while !queue.empty?
            curr_node = queue.shift

            MOVES.each do |move|
                curr_pos = curr_node.value
                new_pos = [curr_pos[0] + move[0], curr_pos[1] + move[1]]

                if valid_pos(new_pos) && !@visited.include?(new_pos)
                    new_node = PolyTreeNode.new(new_pos)
                    curr_node.add_child(new_node)
                    @visited.add(new_pos)
                    queue << new_node
                end

            end
        end

    end

    def valid_pos(pos)
        pos[0].between?(0,7) && pos[1].between?(0,7)
    end

end

my_knight = KnightPathFinder.new([0,0])
p my_knight.root_node
p my_knight.root_node.children
p my_knight.root_node.children[0].children
p my_knight.root_node.children[0].children[0].children