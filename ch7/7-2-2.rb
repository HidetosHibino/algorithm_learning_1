# https://github.com/universato/ac-library-rb/blob/main/lib/priority_queue.rb

# Priority Queue
# Reference: https://github.com/python/cpython/blob/main/Lib/heapq.py
class PriorityQueue
  # By default, the priority queue returns the maximum element first.
  # If a block is given, the priority between the elements is determined with it.
  # For example, the following block is given, the priority queue returns the minimum element first.
  # `PriorityQueue.new { |x, y| x < y }`
  #
  # A heap is an array for which a[k] <= a[2*k+1] and a[k] <= a[2*k+2] for all k, counting elements from 0.
  def initialize(array = [], &comp)
    @heap = array
    @comp = comp || proc { |x, y| x > y }
    heapify
  end

  def self.max(array)
    new(array)
  end

  def self.min(array)
    new(array){ |x, y| x < y }
  end

  def self.[](*array, &comp)
    new(array, &comp)
  end

  attr_reader :heap
  alias to_a heap

  # Push new element to the heap.
  def push(item)
    shift_down(0, @heap.push(item).size - 1)
    self
  end

  alias << push
  alias append push

  # Pop the element with the highest priority.
  def pop
    latest = @heap.pop
    return latest if empty?

    ret_item = heap[0]
    heap[0] = latest
    shift_up(0)
    ret_item
  end

  # Get the element with the highest priority.
  def get
    @heap[0]
  end

  alias top get
  alias first get

  # Returns true if the heap is empty.
  def empty?
    @heap.empty?
  end

  def size
    @heap.size
  end

  def to_s
    "<#{self.class}: @heap:(#{heap.join(', ')}), @comp:<#{@comp.class} #{@comp.source_location.join(':')}>>"
  end

  private

  def heapify
    (@heap.size / 2 - 1).downto(0) { |i| shift_up(i) }
  end

  def shift_up(pos)
    end_pos = @heap.size
    start_pos = pos
    new_item = @heap[pos]
    left_child_pos = 2 * pos + 1

    while left_child_pos < end_pos
      right_child_pos = left_child_pos + 1
      if right_child_pos < end_pos && @comp.call(@heap[right_child_pos], @heap[left_child_pos])
        left_child_pos = right_child_pos
      end
      # Move the higher priority child up.
      @heap[pos] = @heap[left_child_pos]
      pos = left_child_pos
      left_child_pos = 2 * pos + 1
    end
    @heap[pos] = new_item
    shift_down(start_pos, pos)
  end

  def shift_down(star_pos, pos)
    new_item = @heap[pos]
    while pos > star_pos
      parent_pos = (pos - 1) >> 1
      parent = @heap[parent_pos]
      break if @comp.call(parent, new_item)

      @heap[pos] = parent
      pos = parent_pos
    end
    @heap[pos] = new_item
  end
end

HeapQueue = PriorityQueue

N, M = gets.chomp.split(' ').map(&:to_i)

# 大きい塔の[x, y, c]
xyc_large = []
N.times do
  xyc = gets.chomp.split(' ').map(&:to_i)
  xyc_large << xyc
end

# 小さい塔の[x, y, c]
xyc_small = []
M.times do
  xyc = gets.chomp.split(' ').map(&:to_i)
  xyc_small << xyc
end

# p xyc_large
# p xyc_small

# n で表現される集合に要素i が含まれるかを判定して、 T/F を返す関数
def has_bit(n, i)
  n & (1<<i) > 0
end

# [x1, y1, c1] と [x2, y2, c2] を結ぶコスト計算
def calc_edge_cost(xyc1, xyc2)
  # def hypot(a, b)
  #   Math.sqrt(a**2 + b**2)
  # end

  hypot = lambda{|a,b|
    Math.sqrt(a**2 + b**2)
  }

  x1, y1, c1 = xyc1
  x2, y2, c2 = xyc2
  cost = hypot.call(x1-x2, y1-y2)
  cost *= 10 if c1 != c2
  cost
end

ans = 10.0 ** 100

# 小さい塔の中で使うものの集合を全探索
(1 << M).times do |b|
  p "b: #{b}"
  xyc_use = []
  # 大きい塔は全部使う
  xyc_large.each do |xyc|
    xyc_use << xyc
  end

  # 小さい塔はb ビットが立っているものだけ使う
  M.times do |i|
    xyc_use << xyc_small[i] if has_bit(b, i)
  end
  sz = xyc_use.length

  # プリム法で最小全域木を求める
  que = PriorityQueue.new([]) { |x, y| x[0] > y[0] }
  used = [false] * sz
  que << [0.0, 0]
  res = 0.0

  while que.size > 0
    cost, i = que.pop
    unless used[i]
      res += cost
      used[i] = true

      sz.times do |j|
        unless used[j]
          cost = calc_edge_cost(xyc_use[i], xyc_use[j])
          que << [cost, j]
          p "calc_cost_with: #{xyc_use[i]} #{xyc_use[j]} cost: #{cost}"
        end
      end
    end
  end

  ans = [ans, res].min
end

p ans
