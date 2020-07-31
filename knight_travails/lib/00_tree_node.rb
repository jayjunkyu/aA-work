require 'byebug'

class Searchable
    def dfs(target_value)
        if self.value == target_value
            return self
        end

        children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end

        nil
    end

    def bfs(target_value)
        queue = []
        queue << self
        # test commit
        while queue.length > 0
            curr_node = queue.shift

            if curr_node.value == target_value
                return curr_node
            end

            curr_node.children.each do |child|
                queue << child
            end
        end

        nil
    end
end


class PolyTreeNode < Searchable
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if node.nil?
            @parent = nil
            return
        end

        # remove itself from its old parent's children
        # then reassign new parent
        # add self to new parent's children
        @parent.children.delete(self) if !@parent.nil?
        @parent = node
        node.children << self if !node.children.include?(self)
    end
    
    def add_child(node)
        node.parent=(self)
        @children << node if !children.include?(node)
    end

    def remove_child(node)
        raise "Node does not exist." if !children.include?(node)
        node.parent=(nil)
        @children.delete(node)
    end

    def inspect
        @value
    end
end