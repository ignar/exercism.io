class Bst
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
  end

  def insert(value)
    if data >= value
      left.insert(value) if left
      self.left = Bst.new(value) unless left
    else
      right.insert(value) if right
      self.right = Bst.new(value) unless right
    end
  end

  def each(&block)
    return to_enum(:each) unless block_given?

    left.each(&block) if left
    block.call(data)
    right.each(&block) if right
  end
end
