# N
# A1 B1
# A2 B2
# .. ..

# An Bn

# A1 - B2 >= A2 - B1
# A1 + B1 >= A2 + B2

# 全てをBさんが取ったと考える。
# その場合、Bさんの幸福度は B1 + B2 + ... Bn

# そこからAさんが料理i をとる -> 
#   自分の幸福度が +Ai され、  Bさんの幸福度は -Biあいされる。
#   Aさんの相対的な幸福度は Ai + Bi 分増加する

# Bさんが料理i をとる ->
#   Bさんが所有しているままであるため、何も変化しない。

# 二人とも Ai + Bi の値が大きい順に取ることが最適となる。
# そのため、 Ai + Bi をソートして、その値が大きいものを交互に取る家庭を実際にシュミレートすることで答えを求められる。

N = gets.to_i

# A[i] + B[i] の大きい順にソートするため、
# -A[i] + - B[i] を先頭に入れておく
arr =[]
N.times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  arr << [-a - b, a, b]
end

arr.sort!

ans = 0

N.times do |i|
  c, a, b = arr[i]
  if i % 2 == 0
    ans += a
  else
    ans -= b
  end
end

p ans
