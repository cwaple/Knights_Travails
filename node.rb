class Node
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
    @children_counter = 0
  end

  def get_value
    @value
  end

  def get_parent
    @parent
  end

  def set_parent(node)
    @parent = node
  end

  def get_children
    @children
  end

  def get_children_counter
    @children_counter
  end

  def add_child(node)
    node.set_parent(self)
    @children_counter += 1
    @children.push(node)
  end
end