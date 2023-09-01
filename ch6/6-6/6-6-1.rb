A, R, N = gets.chomp.split(' ').map(&:to_i)

# # 実直な実装
# # 数字が大きくなりすぎる
# ans = A * (R ** (N-1))

# # p ans 1000000000 1000000000 1000000000 でやると Infinity
# # 6-6-1.rb:4: warning: in a**b, b may be too big
# # Infinity

# if ans > 10 ** 9
#   p "large"
# else
#   p ans
# end

# # 巨大な数を扱うことを避ける。
# # 10^9 を超えることがわかった時点で計算中止
def solve(a, r, n)
  # a に r を n-1か書ける
  (n-1).times do 
    a *= r

    if a > 10 ** 9
      return "large"
    end
  end

  return a
end

# ans = solve(A, R, N)

# p ans

# 入力と回答の関係を考える。
# R = 1の時、公比=1 であり、 a の値が変わらないためループは N-1回繰り返す。
# 公比2(R=2)の場合、N=31で10^9を越えてループは途中で終了する。
# そのため、solve関数でr=1 の場合は計算せずにA（初稿）を返す

def solve(a, r, n)
  # R=1の時、Nの値を無視してAを返す。
  return a if r == 1

  # a に r を n-1か書ける
  (n-1).times do
    a *= r

    if a > 10 ** 9
      return "large"
    end
  end

  return a
end

ans = solve(A, R, N)

p ans