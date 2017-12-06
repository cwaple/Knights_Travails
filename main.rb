require "./node"
=begin 
Board dimensions are 8x8
Acceptable moves range from [0,0] to [7,7]
At max, a knight has 8 possible moves from pos [x, y]:
  [-2, -1], [-2, 1]
  [-1, 2], [1, 2]
  [2, 1], [2, -1]
  [-1, -2], [1, -2]

1. Create node with starting position
2. Loop through possible move locations, if unique and possible,
    add to tree. 
3. If new location is intended move location, then follow path back up for solution
4. Tree building function will resemble breadth first search, 
    dfs has possibility of infinite search so will be ignored
=end

# breadth first search
def unique?(head, node_value)
  queue = []
  queue.push(head)
  if head.get_value == node_value
    return false
  end
  until queue.empty?
    if head.get_children == []
      return true
    end
    i = 0
    while i < queue[0].get_children_counter do
      if queue[0].get_children[i].get_value == node_value
        return false
      else
        queue.push(queue[0].get_children[i])
        i += 1
      end
    end
    queue.shift
  end
  return true
end

def okay_position?(x, y)
  if x < 0 || x > 7
    return false
  elsif y < 0 || y > 7
    return false
  else 
    return true
  end
end 

def find_route(start_pos, goal_pos, possible_moves)
  head_node = Node.new(start_pos)
  answer_node = nil
  if start_pos == goal_pos 
    return head_node
  end
  goal_found = false
  queue = [head_node]
  until goal_found == true
    new_pos = queue[0].get_value
    possible_moves.each do |move|
      temp_pos = [new_pos[0]+move[0], new_pos[1]+move[1]]
      if okay_position?(temp_pos[0], temp_pos[1]) && unique?(head_node, temp_pos)
        temp_child = Node.new(temp_pos)
        queue[0].add_child(temp_child)
        if temp_pos == goal_pos
          answer_node = temp_child
          goal_found = true
          break
        end
        queue.push(temp_child)
      end
    end
    queue.shift
  end
  return answer_node
end

def print_moves(node)
  temp_list = []
  temp_list.push(node.get_value)
  temp_node = node
  until temp_node.get_parent == nil
    temp_node = temp_node.get_parent
    temp_list.push(temp_node.get_value)
  end

  ordered_list = []
  temp_list.each do |element|
    ordered_list.unshift(element)
  end
  puts ordered_list.inspect
end

possible_moves = [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [-1, -2], [1, -2]]
node = find_route([3,3], [0,0], possible_moves)
print_moves(node)