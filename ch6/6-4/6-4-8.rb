# 各頂点において、以下を管理する。
# length[i]: iを始点とするパスのうち、最も長いものの長さ

# これを求めるには、iから辺が伸びている頂点j それぞれについてlength[j] を求め、その中で最も長いものに繋ぐ
# トポロジーソートの逆順に計算することで、全長点について、length[i] を求められる。

# 始点を最初に呼び出し、その先に続く頂点について再起的に呼び出します。
# 今回のグラフでは始点は1つに限らないため、その頂点に入ってくるような変の数(入字数)が０である頂点全てについて呼び出しましょう。

N, M = gets.chomp.split(' ').map(&:to_i)

edges = Array.new(N) { [] }

# 入字数。始点の判定に使う。　なければ始点ということになる。
indeg = [0] * N

M.times do
  x, y = gets.chomp.split(' ').map(&:to_i)
  edges[x-1] << y-1 # 隣接リストなので追加
  indeg[y-1] += 1
end

p "edges: #{edges}"
p "indeg: #{indeg}"

# 頂点i から始まるパスの最大値
length = [0] * N

# done[i]: cost[i] が計算済みであることを示すフラグ
done = [false] * N

define_method :rec do |i|
  return length[i] if done[i]

  length[i] = 0

  edges[i].each do |e|
    length[i] = [length[i], rec(e) + 1].max
  end

  # 計算フラグを立てる
  done[i] = true
  length[i]
end

N.times do |i|
  rec(i) if indeg[i] == 0
end

# p length
p length.max
