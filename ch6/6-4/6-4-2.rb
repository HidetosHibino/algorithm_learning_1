# 0 ~ L ゴール
# N 個のハードル

# i番目のハードルは 座標Xiにある
#   X1    X2
# 0 1 2 3 4

# 行動1  距離１を走って進む (合計1)
# 行動2  距離0.5 進み、ジャンプして距離1を進み、また距離を0.5を走って進む (合計2)
# 行動3  距離0.5 進み、ジャンプして距離3を進み、また距離を0.5を走って進む (合計4)

# 走っているときは T1秒 /1距離
# ジャンプしている時は、 T2秒 /1距離
# 走っているときに。ハードルに当たる（ジャンプ中ではないときに座標x にいて、座標xにハードルがある）場合、追加で T3秒

# 座標L を通過した時間

n, l = gets.chomp.split(' ').map(&:to_i)

x = gets.chomp.split(' ').map(&:to_i)

t1, t2, t3 = gets.chomp.split(' ').map(&:to_i)

# ハードルを管理する配列
h = Array.new(l+1, false)

# ハードルがある場所は、trueにする
x.each do |i|
  h[i] = true
end

# cost[i]: 座標i で行動を終了するまでの最小時間
# 大きな値で初期化しておき、min を用いて更新する。
cost = [10**100] * (l + 1)

# 初期条件
cost[0] = 0

(1..l).each do |i|
  # 行動1    #今までの探索でのminと,今回の行動での結果コストを比較
  cost[i] = [cost[i], cost[i-1] + t1].min

  # 行動２
  cost[i] = [cost[i], cost[i-2] + t1 + t2].min if i > 2

  # 行動3
  cost[i] = [cost[i], cost[i-4] + t1 + 3 * t2].min if i > 4

  # もしハードルがあれば加算
  cost[i] += t3 if h[i]
end

# ハードルを飛びながら超えた時の考慮
ans = cost[l]
[l-3, l-2, l-1].each do |i|
  ans = [ans, cost[i] + t1 / 2 + t2 * (2 * (l - i) - 1) / 2].min if i >= 0
end

puts ans
