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

H, W = gets.chomp.split(' ').map(&:to_i)
A = []

H.times do
  A << gets.chomp.split(' ').map(&:to_i)
end

# ダイクストラ法で、始点(si, sj)から各マスへの最短距離を求める
def grid_dijkstra(si, sj)
  dist = []
  H.times { dist << [10 ** 100] * W }

  que = PriorityQueue.new([]) { |x, y| x[0] < y[0] }
  dist[si][sj] = 0
  que << [0, si, sj]
  while que.size > 0
    d, i, j = que.pop
    next if d > dist[i][j]

    [[i-1,j], [i+1,j], [i, j-1], [i, j+1]].each do |i2, j2|
      if (0 <= i2 && i2 < H) && (0 <= j2 && j2 < W) && A[i2][j2] + d < dist[i2][j2]
        dist[i2][j2] = A[i2][j2] + d
        que << [dist[i2][j2], i2, j2]
      end
    end
  end

  return dist
end

# 左下隅、右下隅、右上隅からの距離を求める
dist1 = grid_dijkstra(H-1, 0)
dist2 = grid_dijkstra(H-1, W-1)
dist3 = grid_dijkstra(0, W-1)

dist1.each do |d|
  p d
end

# T字路の交差点を全探索する。
ans = 10**100
H.times do |i|
  W.times do |j|
    res = dist1[i][j] + dist2[i][j] + dist3[i][j] - 2 * A[i][j]
    ans = [ans, res].min
  end
end

p ans
