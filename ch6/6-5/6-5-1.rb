N = gets.to_i
A = []

(N-1).times do |i|
  # A[i]は A[i][i+1]からスタートするため、0からiまで(i+1)個はダミーで埋める。
  list = gets.chomp.split(' ').map(&:to_i)
  A << [0] * (i + 1) + list
end

# p A

# 集合としてあり得るものの個数 2**n でも同じ
# << はシフト演算子。 2進数表記したときに、左にずらす
ALL = 1 << N

# happy[n]: nで表現される集合をグループにしたときの幸福度
happy = [0] * ALL

# n で表現される集合に要素iが含まれるかを判定して、 True/Falseを返す関数
define_method :has_bit do |n, i|
  return (n & (1<<i) > 0)
end

# happyの値を前もって計算する。
# happy は ALL通り(0~2^n -1)
# それぞれは、N人の社員それぞれについて加える・加えないを管理する。
# 状態n について考えるとき、i と j　について (i = j になることはないので、i < j　として考え、ゆえに jは　 (i+1...n))
# i, j　が状態n に含まれるならば、その組み合わせの幸福度を 状態nのhappy に足す。
ALL.times do |n|
  N.times do |i|
    (i + 1...n).each do |j|
      if has_bit(n, i) && has_bit(n, j)
        happy[n] += A[i][j]
      end
    end
  end
end

# 答えの値。小さい値で初期化して、maxで更新する。
ans = -10**100

ALL.times do |n1|
  ALL.times do |n2|
    # n1とn2 で重複があれば無視する
    next if n1 & n2 > 0

    # n3 を補集合として求めて答えを更新する
    n3 = ALL-1 - (n1|n2)
    # p "#{n1}: #{n2}: #{n3}"
    ans = [ans, happy[n1] + happy[n2] + happy[n3]].max
  end
end

p ans
