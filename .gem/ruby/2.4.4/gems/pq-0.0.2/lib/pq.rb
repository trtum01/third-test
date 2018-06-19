require 'forwardable'

class PQ
  VERSION = '0.0.2'.freeze

  extend Forwardable
  include Enumerable

  def initialize
    @elements = [nil]
    @weight = block_given? ? ->(a) { yield a } : ->(a) { a }
    @mutex = Mutex.new
  end

  def inspect
    "#<#{self.class.inspect} #{@elements.compact.reverse.map(&:inspect).join(', ')}>"
  end

  def add(*elements)
    @mutex.synchronize do
      elements.each do |element|
        @elements << element
        up! size
      end
    end
    self
  end

  alias << add

  def pop
    @mutex.synchronize do
      swap! 1, size
      max = @elements.pop
      down! 1
      max
    end
  end

  def any?
    !empty?
  end

  def empty?
    count.zero?
  end

  def size
    @elements.size.pred
  end

  alias count size

  def_delegators :enumerator, :each

  private

  def up!(index)
    return if index <= 1

    parent = (index / 2)
    return if need_swap? parent, index

    swap! index, parent
    up! parent
  end

  def down!(index)
    child = (index * 2)

    return if child > count

    not_the_last = child < count
    left = @elements[child]
    right = @elements[child.next]
    child += 1 if not_the_last && ((@weight[right] <=> @weight[left]) == 1)

    return if need_swap? index, child

    swap! index, child
    down! child
  end

  def need_swap?(a, b)
    (@weight[@elements[a]] <=> @weight[@elements[b]]) > 0
  end

  def swap!(a, b)
    @elements[a], @elements[b] = @elements[b], @elements[a]
  end

  def enumerator
    Enumerator.new do |enum|
      enum << pop while any?
    end
  end
end

PriorityQueue = PQ
