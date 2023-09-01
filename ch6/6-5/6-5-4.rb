# 半分前列挙
# 要素を半分ずつのグループに分けて、それぞれのグループについての部分集合の前列挙を行い、その結果を組み合わせることで答えを求める。

# N X
# w1
# w2
# ...
# wn

# ここで、品物をグループAとグループBの半分ずつ分けて、それぞれで全列挙することを考えます。
# そうすれば最大でもそれぞれ 2^ n/2 になる

# ここでグループAからの1つの選び方について、その重さ合計がWa だったとします。
# この選び方を、グループBからの選び方のうち重さの合計が X-Wa であるものと組み合わせると全体の重さがXになる

# つまり、グループBについては、どのようなWa に対しても、「グループBからの選び方のうち、重さ合計がX-Waであるもの個数」がすぐわかるようにしておく必要がある。
# これは全列挙した結果を辞書型などに格納してくことで実現できる。
N, X = gets.chomp.split(' ').map(&:to_i)

# 偶数番目と奇数番目で半分ずつに振り分けていく。
A = []
B = []

N.times do |i|
  w = gets.to_i

  if i%2 == 0
    A << w
  else
    B << w
  end
end

# nで表現される集合に、要素i が含まれるかを判定する。
def has_bit(n, i)
  n & (1<<i) > 0
end

# グループBを全列挙して重さごとに集計
dic = Hash.new(0)
# dic = Hash.new {|hash, key| hash[key] = 0}
(1<<B.length).times do |n|
  s = 0
  N.times do |i|
    s += B[i] if has_bit(n, i)
  end
  dic[s] += 1
end

# p dic
# {0=>1, 1=>1, 3=>1, 4=>1}

# グループAを全列挙して答えを求める。
ans = 0
(1<<A.length).times do |n|
  s = 0
  N.times do |i|
    s += A[i] if has_bit(n, i)
  end
  ans += dic[X-s]
end

p ans
