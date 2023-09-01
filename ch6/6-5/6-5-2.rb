# N M 
# S1 C1
# S2 C2
# .. ..
# SM CM

# i 番目を買うか/その時の状態 を次元として、コストの最小値を管理する
N, M = gets.chomp.split(' ').map(&:to_i)

# 1始まりにするため、ダミーを入れる。 Sは整数に治す
S = [0]
C = [0]

M.times do |i|
  s, c = gets.chomp.split(' ')
  s_val = 0
  N.times do |j|
    s_val = (s_val | 1 << j) if s[j] == 'Y'
    # s_val | 1 << j で、　s_val と 1 << j の論理和が取得できる
  end
  S << s_val
  C << c.to_i
end

ALL = 1 << N

# cost[i][n]: セットi まで見て揃った商品の部分がんである時のコスト最小値
cost = []
INF = 10**10
(M+1).times do |i|
  cost << [INF] * ALL
end

cost[0][0] = 0
(1..M).each do |i|
  ALL.times do |n|
    cost[i][n] = [cost[i][n], cost[i-1][n]].min
    cost[i][n | S[i]] = [cost[i][n | S[i]], cost[i - 1][n] + C[i]].min
  end
end

ans = cost[M][ALL-1]
ans = -1 if ans == INF

p ans
