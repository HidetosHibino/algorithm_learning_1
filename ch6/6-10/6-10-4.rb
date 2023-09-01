INF = 10**18

N, M = gets.chomp.split(' ').map(&:to_i)

# 全ての頂点のくみについての最短距離を保存する2次元配列distを作る。
dist = []

# 最初は辺が一本も貼られていないため、無限の辺が貼られていると考えて
# N x N個の INF で埋めておく
N.times do |i|
  dist << []
  N.times do |j|
    dist[i] << INF
  end
end

M.times do 
  u, v, c = gets.chomp.split(' ').map(&:to_i)
  dist[u][v] = c
end

# iからiへの同じ頂点同士の距離は0としておく
N.times do |i|
  dist[i][i] = 0
end

N.times do |k|
  N.times do |x|
    N.times do |y|
      dist[x][y] = [dist[x][y], dist[x][k] + dist[k][y]].min
    end
  end
end

ans = 0
N.times do |i|
  N.times do |j|
    ans += dist[i][j]
  end
end

p ans
