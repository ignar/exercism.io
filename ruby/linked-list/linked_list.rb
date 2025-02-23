class Node
  attr_reader :value
  attr_accessor :prev, :succ

  def initialize(prev, value, succ)
    @value = value
    @prev = prev || self
    @succ = succ || self
  end

  def link
    prev.succ = self
    succ.prev = self
    self
  end

  def unlink
    prev.succ = succ
    succ.prev = prev
    self
  end
end

class Deque
  attr_accessor :head

  def initialize
    @head = Node.new(nil, :none, nil)
  end

  def push(value)
    new_node = Node.new(head.prev, value, head)
    new_node.link
    self
  end

  def pop
    head.prev.unlink.value
  end

  def shift
    head.succ.unlink.value
  end

  def unshift(value)
    new_node = Node.new(head, value, head.prev)
    new_node.link
    self
  end
end
