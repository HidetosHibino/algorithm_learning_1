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

# N M
# u0   v0   c0
# u1   v1   c1
# u2   v2   c2
# ..   ..   ..
# uM-1 vM-1 cM-1

N, M = gets.chomp.split(' ').map(&:to_i)

# 隣接リスト
G = Array.new(N) { [] }

M.times do
  u, v, c = gets.chomp.split(' ').map(&:to_i)
  G[u] << { v:, c: }
  # 総合の距離でとるっぽい(dist[k])ので、costでは優先付けしない
end

# 頂点0から各頂点への最短距離を保持する配列
# N個の -1 で初期化(-1 は未訪問である) dist[0]は始点なので0にする
dist = [-1] * N
dist[0] = 0

# ダイクストラ法で使うヒープ
Q = PriorityQueue.new([]) # { |x, y| x[:d] > y[:d] }

# 始点の頂点0を ヒープに追加
# {d: 距離, 頂点となるようにする}
Q << { d: 0, i: 0 }

# ヒープから取り出したことがあるかを保存する配列
done = []
N.times do
  done << false
end

# ダイクストラ法で各頂点への最短距離を求める。
while Q.size > 0
  d, i = Q.pop.values #  { d: 0, i:0 }
  next if done[d]

  done[i] = true
  # 頂点i に隣接する頂点を順番に見る。
  # 見ている頂点をj とする
  # また、i からj に移動すると気に使う辺の重みをc とする。
  G[i].each do |hashy|
    j, c = hashy.values
    # jが未訪問だったとき、あるいはjへの最短距離が更新可能だったとき
    # jへの最短距離を更新して、ヒープの末尾に追加する
    if dist[j] == -1 || dist[j] > dist[i] + c
      dist[j] = dist[i] + c
      Q << { d: dist[j], i: j }
    end
  end
end

p dist[N-1]
