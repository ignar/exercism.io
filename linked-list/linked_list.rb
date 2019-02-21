class Node
  attr_reader :value
  attr_accessor :prev, :next

  def initialize(value, prev)
    @value = value
    @prev = prev
  end
end

class Deque
  attr_accessor :head, :tail

  def initialize
    @head = @tail = nil
  end

  def push(value)
    new_node = Node.new(value, tail)

    if head.nil? && tail.nil?
      self.head = self.tail = new_node
    else
      tail.next = new_node
      self.tail = self.tail.next
    end
  end

  def pop
    value = tail&.value

    if head == tail
      self.head = self.tail = nil
    end

    if tail && tail.prev
      previous = tail.prev
      previous.next = nil
      self.tail = previous
    end

    value
  end

  def shift
    value = head&.value

    if head == tail
      self.head = self.tail = nil
    end

    if head && head.next
      next_node = head.next
      head.next = nil
      next_node.prev = nil
      self.head = next_node
    end

    value
  end

  def unshift(value)
    new_node = Node.new(value, nil)
    new_node.next = head

    self.head.prev = new_node if head
    self.tail = new_node unless tail

    self.head = new_node
  end
end
