# There are two ways to implement a SET, either using a hash table,
# or with a tree structure (like a red-black tree).
# In given examples a keys a always less then 10, so hash function
# is not the optimal implementation, and I choose a tree way.

require 'forwardable'

class CustomSet
  extend Forwardable

  def_delegators :data, :each, :map, :empty?, :reduce, :count

  def initialize(collection)
    @data = Tree.new collection.shift
    collection.each { |element| @data.add(element) }
  end

  def member?(value)
    return false if data.empty?
    !!data.search(value)
  end

  def add(value)
    tap { data.add(value) }
  end

  def subset?(set)
    return true if empty? && set.empty?
    return true if empty? && !set.empty?

    result = data.reduce([]) do |memo, value|
      memo << set.member?(value)
      memo
    end

    !result.empty? && result.all?
  end

  def disjoint?(set)
    return true if empty? || set.empty?

    result = data.reduce([]) do |memo, value|
      memo << set.member?(value)
      memo
    end

    result.empty? || result.none?
  end

  def intersection(set)
    return self.class.new([]) if set.empty? || data.empty?

    array1 = data.reduce([]) { |memo, value| memo << value }
    array2 = set.reduce([]) { |memo, value| memo << value }

    common_elements = array1 & array2
    self.class.new(common_elements)
  end

  def difference(set)
    return self.class.new([]) if data.empty?

    array1 = data.reduce([]) { |memo, value| memo << value }
    array2 = set.reduce([]) { |memo, value| memo << value }

    common_elements = array1 - array2
    self.class.new(common_elements)
  end

  def union(set)
    array1 = data.reduce([]) { |memo, value| memo << value }
    array2 = set.reduce([]) { |memo, value| memo << value }

    common_elements = array1 + array2
    common_elements.compact!
    self.class.new(common_elements)
  end

  def ==(set)
    return false if count != set.count

    array1 = data.reduce([]) { |memo, value| memo << value }
    array2 = set.reduce([]) { |memo, value| memo << value }

    return false if array1.size != array2.size

    array1 == array2
  end

  private

  attr_reader :data
end

class Tree
  include Enumerable

  attr_reader :data, :count
  attr_accessor :left, :right

  def initialize(data)
    @count = 0
    add(data) unless data.nil?
  end

  def empty?
    [data, left, right].all?(&:nil?)
  end

  def search(value)
    return if value.nil? || data.nil?
    if value == data
      value
    elsif value < data
      left.search(value) if left
    elsif value > data
      right.search(value) if right
    end
  end

  def add(value)
    return if search(value)

    @count += 1

    if data.nil?
      @data = value
    elsif value <= data
      left.add(value) if left
      self.left = Tree.new(value) unless left
    else
      right.add(value) if right
      self.right = Tree.new(value) unless right
    end
    self
  end

  def each(&block)
    return to_enum(:each) unless block_given?

    left.each(&block) if left
    block.call(data)
    right.each(&block) if right
  end
end
