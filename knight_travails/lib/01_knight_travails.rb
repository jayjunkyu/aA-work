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
        @start_pos = start_pos
    end

    def build_move_tree(node)  # building all possible subsequence moves from start_pos
        queue = [node]  # using a queue do build a tree in a BFS manner

        while !queue.empty?  # keep building tree until no possible moves left
            curr_node = queue.shift

            MOVES.each do |move|
                curr_pos = curr_node.value
                new_pos = [curr_pos[0] + move[0], curr_pos[1] + move[1]]
                
                # for each possible move, add the node as a child to curr_node
                if valid_pos(new_pos) && !@visited.include?(new_pos)
                    new_node = PolyTreeNode.new(new_pos)
                    curr_node.add_child(new_node)
                    @visited.add(new_pos)
                    queue << new_node  # new_node gets added to queue to become a parent
                end

            end
        end

    end

    def valid_pos(pos)
        pos[0].between?(0,7) && pos[1].between?(0,7)
    end

    def find_path(end_pos)  # returns path to reach end_pos
        end_node = root_node.dfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)  # helper method to store path
        path = []
        curr_node = end_node
        until curr_node == root_node  # store path until root_node is reached
            path.unshift(curr_node.value)
            curr_node = curr_node.parent  # going backwards from end_pos
        end
        path.unshift(curr_node.value)

        path
    end

end

my_knight = KnightPathFinder.new([0,0])
p my_knight.find_path([7,6])
p my_knight.find_path([6,2])