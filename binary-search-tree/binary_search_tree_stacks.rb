class Bst
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
  end

  def each
    return to_enum(:each) unless block_given?

    stack = []
    values = []
    local_root = self

    while local_root != nil
      stack << local_root
      local_root = local_root.left
    end

    while stack.length > 0
      local_root = stack.pop
      yield local_root.data if block_given?
      values << local_root.data

      local_root = local_root.right
      while local_root != nil
        stack << local_root
        local_root = local_root.left
      end
    end

    values
  end

  def insert(value)
    previous_node = nil
    local_root = self
    new_node = Bst.new(value)

    while local_root != nil
      previous_node = local_root
      if new_node.data < local_root.data
        local_root = local_root.left
      else
        local_root = local_root.right
      end
    end

    if previous_node.data >= new_node.data
      previous_node.left = new_node
    else
      previous_node.right = new_node
    end
  end
end
