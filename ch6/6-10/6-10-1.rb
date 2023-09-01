# 確辺の重みが1で等しい場合は、幅優先探索で解決できる。

# N M
# a1 b1
# a2 b2
# .. ..
# am bm

# a1 から n に行きたい

N, M = gets.chomp.split(' ').map(&:to_i)

# 隣接リスト 
g = Array.new(N) { [] }

M.times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  ai = a - 1
  bi = b - 1
  g[ai] << bi
  g[bi] << ai # 逆も忘れない
end

# 頂点0から各頂点への最短経路を保持する配列
dist = [-1] * N

# 幅優先探索で使うキュー
# キューに始点となる頂点0を追加する
q = []
q << 0

# 始点となる頂点0への最短距離は0とする
dist[0] = 0

while q.length > 0
  i = q.shift
  g[i].each do |j|
    if dist[j] == -1
      dist[j] = dist[i] + 1
      q << j
    end
  end
end

if dist[N-1] == 2
  p 'POSSIBLE'
else
  p 'IMPOSIBBLE'
end
