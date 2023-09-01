# n w
# w1 v1
# w2 v2
# .. ..
# wn vn

N, W = gets.chomp.split(' ').map(&:to_i)

ws = [0]
vs = [0]

N.times do
  w, v = gets.chomp.split(' ').map(&:to_i)
  ws << w
  vs << v
end

# 重さと価値の二次元配列 価値の総和の最大量
value = []

(0..N).each do |i|
  value << [-10**18] * (W + 1)
end

# 初期条件
value[0][0] = 0

# iが小さい順に求めていく
(1..N).each do |i|
  (W + 1).times do |w|
    # 品物iを使わない場合
    value[i][w] = [value[i][w], value[i - 1][w]].max

    # 品物iを使う場合
    if w-ws[i] >= 0  # w に対して、品物i （重さws[i]）を追加できるのか？
                    # 例えば w = 100 のとき、
                    # ws[i] が100 よりも大きければ、そもそも追加できない。
                    # ws[i] が100以下であれば、品物i を追加できる。
                    # 何に追加するかというと、
                    # ・品物i を追加する前の状態 -> 品物i-1 を使っていて([i-1])
                    # ・重さが w から 品物[i]で追加される重さ(ws[i])を引いた時の重さの状態 ( => 重さは w-ws[i])
                    # その時のvalue　→ value[i-1][w-ws[i]]
                    # であり、それに今回追加する品物i のvalue　を足す。
      value[i][w] = [value[i][w], value[i - 1][w - ws[i]] + vs[i]].max
    end
  end
end

ans = value[N].max

p ans

value.each do |v|
  p v
end

# 扱う二次元配列は　itemと wightを持っていた。
# これは 「ある品物まで使い、重さの総和」がある時の　「価値の総和の最大値」についての配列
# value = [item][weight]だった

# ただ、これを
# weight = [item][value]　として
# 「ある品物まで使い、価値の総和」があるときの、　「重さの総和の最小値」についての配列として解くことができる
