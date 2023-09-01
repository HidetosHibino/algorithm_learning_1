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

# 隣接リストとしてグラフの情報を保持する配列
G = Array.new(N) {[]}

M.times do
  u, v, c = gets.chomp.split(' ').map(&:to_i)

  # 頂点 u から出て、vへ向かう重みのc の辺を保存する。
  G[u] << { v:, c: }

  # 無効グラフとなるため、反対向きも保存
  G[v] << { u:, c: }
end

# プリム法で、最小全域木問題を解く

# 頂点がマークされているかどうかを管理する配列
# 頂点i がマークされているとき、 marked[i] = true となる
# 最初はどの頂点もマークされていないため N個の False で埋めておく

marked = [false] * N

# マークされている頂点数を保持する変数
# Nになったら終了する
marked_count = 0

# 最初に頂点0を選んでマークする
marked[0] = true
marked_count += 1

# 次に選ぶ辺の候補を入れるヒープ
Q = PriorityQueue.new([]) { |x, y| x[:c] < y[:c] }

# 頂点0 に隣接する辺を調べ、ヒープに入れる。

G[0].each do |hashy|
  v, c = hashy.values
  Q << { c:, v: }
end

# 最小探索木の重みの合計を保存する変数
sum = 0

# 全ての頂点がマークされるまで繰り返す
while marked_count < N

  #　ヒープから、最小の重みの辺を取り出す。
  # これは（辺の重み, 選んだ時にマークする頂点）
  c, i = Q.pop.values
  # # PriorityQueue に 比較用式を渡して、小さいものが優先されるようにしないといけない気がする
  # p "c: #{c}, i:#{i}"
  # 辺に繋がる頂点i がすでにマークされていた場合、スキップ
  next if marked[i]

  # 頂点i をマークする。
  marked[i] = true
  marked_count += 1

  # 使った辺は最小全域木となるため、重みを保存しておく
  sum += c

  # 新たにマークした頂点i に隣接する辺を調べる
  G[i].each do |hashy|
    j, c = hashy.values
    next if marked[j]

    Q << { c:, j: }
  end
end

# 最小全域木の重みの合計
p sum
