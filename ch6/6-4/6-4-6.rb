# 動的計画法
# cost[i][j]: マス(i, j) の数字が n である時、スタート地点から S -> 1 -> 2 -> ... n を正しく通って
# マス(i, j) に到達する移動回数の最小値

# 遷移を考える。
# マスを数字ごとに分類する。そして数字が n であるマスのcost計算は、数字がn-1 であるマスからの移動を全て試す。

# マス(a1, b2) から マス(a2, b2) の移動距離は、 |a1-a2| + |b1-b2| (斜め移動はできないので)である 
# このように計算される点をマンハッタン距離という

N, M = gets.chomp.split(' ').map(&:to_i)

A = []

N.times do
  A << gets.chomp.split('')
end

group = []
11.times do |i|
  group << []
end

# group で番号ごとに座標を分類。スタートは0 ゴールは10 とする
N.times do |i|
  M.times do |j|
    if A[i][j] == 'S'
      n = 0
    elsif A[i][j] == 'G'
      n = 10
    else
      n = A[i][j].to_i
    end

    group[n] << [i, j]
  end
end

# cost[i][j]: 数字を正しく通ってマス(i, j) にたどり着く最小移動回数
# 非常に大きい値で初期化しておく。

INF = 10**100
cost = Array.new(N) { Array.new(M, INF) }

# 初期条件：　スタート地点の座標はgroup[0][0]
si, sj = group[0][0]
cost[si][sj] = 0

(1...11).each do |n|
  # 更新したいマスそれぞについてループ
  group[n].each do |i, j|
    # p "n:#{n} -> i:#{i}, j:#{j}"
    # 前のマスまでの距離を全て確認
    group[n - 1].each do |i2, j2|
      distance = (i2 - i).abs + (j2 - j).abs
      cost_from_pre = cost[i2][j2] + distance
      cost[i][j] = [cost[i][j], cost_from_pre].min
    end
  end
end

# ゴール地点は group[10][0]
gi, gj = group[10][0]
ans = cost[gi][gj]

ans = -1 if ans == INF

p ans
