class Node
    attr_accessor :data
    attr_accessor :left_child
    attr_accessor :right_child
    attr_accessor :parent

    def initialize(data)
        @data = data
        @left_child = nil
        @right_child = nil
        @parent = nil
    end

    def comparable(node)
        if self.data > node.data
            return 1
        elsif self.data < node.data
            return -1
        else
            return 0
        end
    end
end

class Tree

    def initialize(array)
        @array = array
        @root = nil
    end

    def build_tree
        @array.uniq!
        @array.sort!
        @root = Node.new(@array[@array.size / 2])
        @array.each {|item| node_placement(@root, Node.new(item))}
    end

    def node_placement(current_node, node)
        if current_node.comparable(node) == 1
            if current_node.left_child != nil
                current_node = current_node.left_child
                node_placement(current_node, node)
            else
                current_node.left_child = node
                current_node.left_child.parent = current_node
            end
        elsif current_node.comparable(node) == -1
            if current_node.right_child != nil
                current_node = current_node.right_child
                node_placement(current_node, node)
            else
                current_node.right_child = node
                current_node.right_child.parent = current_node
            end
        end
    end

    def insert(value)
        node = Node.new(value)
        node_placement(@root, node)
    end

    def delete(value)
        deleted_node = search(@root, value)
        right = deleted_node.right_child
        left = deleted_node.left_child
        if deleted_node.parent.right_child = deleted_node
            deleted_node.parent.right_child = nil
            if right != nil
                node_placement(@root, right)
            end
            if left != nil
                node_placement(@root, left)
            end
        elsif deleted_node.parent.left_child = deleted_node
            deleted_node.parent.right_child = nil
            if right != nil
                node_placement(@root, right)
            end
            if left != nil
                node_placement(@root, left)
            end
        end
    end

    def find(value)
        return search(@root, value)
    end

    def search(current_node, value)
        if current_node.data < value
            if current_node.right_child != nil
                current_node = current_node.right_child
                search(current_node, value)
            else
                return "Value not present."
            end
        elsif current_node.data > value
            if current_node.left_child != nil
                current_node = current_node.left_child
                search(current_node, value)
            else
                return "Value not present."
            end
        elsif current_node.data = value
            current_node
        end
    end

    def level_order
        arr = []
        arr.push(@root)
        print "#{@root.data} "
        return breath(arr)
    end

    def breath(arr)
        current_node = arr.shift
        if current_node.left_child != nil
            arr.push(current_node.left_child)
            print "#{current_node.left_child.data} "
        end
        if current_node.right_child != nil
            arr.push(current_node.right_child)
            print "#{current_node.right_child.data} "
        end
        if arr.length < 1
            return
        else
            return breath(arr)
        end
    end

    def preorder
        preorder_action(@root)
    end

    def preorder_action(node)
        if node == nil
            return
        else
            print "#{node.data} " 
            preorder_action(node.left_child)
            preorder_action(node.right_child)
        end
    end

    def inorder
        inorder_action(@root)
    end

    def inorder_action(node)
        if node == nil
            return
        else
            inorder_action(node.left_child)
            print "#{node.data} "
            inorder_action(node.right_child)
        end
    end

    def postorder
        postorder_action(@root)
    end

    def postorder_action(node)
        if node == nil
            return
        else
            postorder_action(node.left_child)
            postorder_action(node.right_child)
            print "#{node.data} "
        end
    end

    def depth(node=@root)
        depth_action(node) - 1
    end

    def depth_action(node)
        if node == nil
            return 1
        else
        left = depth_action(node.left_child)
        right = depth_action(node.right_child)
        max = left > right ? left : right
        return max + 1
        end
    end

    def balanced?
        arr = []
        arr.push(depth(@root.left_child))
        arr.push(depth(@root.right_child))
        arr.sort!
        return arr[1] - arr[0] <= 1
    end

    def rebalance!
        arr = []
        answer = []
        arr.push(@root)
        answer.push(@root.data)
        @array = rebalance_action(arr, answer)
        build_tree
    end

    def rebalance_action(arr, answer)
        current_node = arr.shift
        if current_node.left_child != nil
            arr.push(current_node.left_child)
            answer.push(current_node.left_child.data)
        end
        if current_node.right_child != nil
            arr.push(current_node.right_child)
            answer.push(current_node.right_child.data)
        end
        if arr.length < 1
            return answer
        else
            return rebalance_action(arr, answer)
        end
        
    end


end
array = Array.new(15) { rand(1..100) }
puts array
b_tree = Tree.new(array)
b_tree.build_tree
puts b_tree.balanced?
b_tree.level_order
puts
b_tree.postorder
puts
b_tree.preorder
puts
b_tree.inorder
puts
b_tree.insert(40)
b_tree.insert(44)
b_tree.insert(45)
b_tree.insert(46)
b_tree.insert(47)
puts b_tree.balanced?
b_tree.rebalance!
puts b_tree.balanced?
b_tree.level_order
puts
b_tree.postorder
puts
b_tree.preorder
puts
b_tree.inorder
puts
