# N M
# n1 v1 # uiとviをつなぐ　通行量は１
# n2 v2
# .. ..
# uM vM
# s # 今いる町
# K 
# t1 t2 ... tK #　目的地一覧 少なくとも一回訪れる必要がる

# 1.まず始点s と t1, t2 ... tK の合計 k+1の頂点について、その頂点を始点とする幅優先探索を行い、他の頂点への最小移動コストを求める。
#   計算量はO(K(N + M))
# 2.巡回セールスマン問題をしてbit DP で答えを求める。その遷移計算には、前ステップで求めた頂点間の移動コストを使う。
#   計算量はO(K^2* 2^k)

N, M = gets.chomp.split(' ').map(&:to_i)

edges = Array.new(N) { [] }

M.times do
  n, v = gets.chomp.split(' ').map(&:to_i)
  ni, vi = [n, v].map { |i| i - 1 }
  edges[ni] << vi
  edges[vi] << ni
end

S = gets.to_i - 1

K = gets.to_i
T = gets.chomp.split(' ').map(&:to_i)

K.times do |i|
  # t1, t2 ... tK を配列の添字で扱えるように -1
  T[i] -= 1
end

# 実装上 T[K] = S そしておく
T << S

INF = 10**100

# Dist[k][l] : 頂点T[k] から 頂点T[l] までの移動コスト
Dist= []
T.each do |t1|
  # 幅優先探索
  # 始点がある かつ 移動コスト（重さ）が一定なので幅優先
  dist = [INF] * N
  que = []
  que << t1
  dist[t1] = 0
  while que.length > 0
    i = que.shift
    edges[i].each do |j|
      if dist[j] == INF
        dist[j] = dist[i] + 1
        que << j
      end
    end
  end
  res = []
  # p "ti:#{t1} dist: #{dist}"
  T.each do |t2|
    res << dist[t2]
  end
  # ここで、K * K のDistに変換する
  Dist << res
end

# Dist.each do |d|
#   p d
# end

# 巡回セールスマン問題
# cost[n][i]: Tの中で訪れた頂点の集合がnで、
# 最後にいる頂点がT[i]であるときのコスト最小値
ALL = 1 << K
cost = []
ALL.times do |n|
  cost << [INF] * K
end

# 始点Sから各T[i] に移動した状態を初期状態とする
K.times do |i|
  cost[1 << i][i] = Dist[K][i]
end

# n で表現される集合に要素i が含まれるかを判定して、 T/Fを返す関数
def has_bit(n, i)
  n & (1 << i) > 0
end

ALL.times do |n|
  K.times do |i|
    # iからj に移動する遷移を試す
    K.times do |j|
      # すでに訪問済みか、同じ頂点は無視する。
      next if has_bit(n, j) || i == j

      # 事前計算したT[i]からT[j]への最小距離を使う
      cost[n | (1 << j)][j] = [cost[n | (1 << j)][j], cost[n][i] + Dist[i][j]].min
    end
  end
end

# K個の頂点全てを訪問して、どこかの頂点にいる中での最小コストが答え
p cost[ALL - 1].min
