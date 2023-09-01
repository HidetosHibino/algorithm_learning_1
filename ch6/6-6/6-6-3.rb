# abcで、a=1 b=2 c=3 のとき、それの和は
# (1*1*1) + (1*1*2) + (1*1*3) + (1*2*1) + (1*2*2) + (1*2*3) =18

# # 実直に実装
# # 計算量はO(ABC)

# A, B, C = gets.chomp.split(' ').map(&:to_i)

# sum = 0

# (1..A).each do |a|
#   (1..B).each do |b|
#     (1..C).each do |c|
#       sum += a * b * c
#       # p sum
#       sum %= 998244353
#     end
#   end
# end

# p sumt

# Cについて、 Σabc = ab*1 + ab*2 + ... ab*(C-1) + ab*C = ab(1+2+...C)
# ここで、1+2+...C は 1/2 * C (1+C) なので

# Σabc = ab * 1/2*C(1+C) となる
# 同様に変形すると,
# ΣΣΣabc = Σa * 1/2*B(1+B) * 1/2*C(1+C)
# = 1/2*A(1+A) * 1/2*B(1+B) * 1/2*C(1+C)
# となる。

# D = 1/2*A(1+A), E = 1/2*B(1+B), F = 1/2*C(1+C) とすると、
# ΣΣΣabc = 1/2*A(1+A) * 1/2*B(1+B) * 1/2*C(1+C) = DEF となり、DEFと表すことができる。
# これにより、計算量をO(1)にすることができる。

A, B, C = gets.chomp.split(' ').map(&:to_i)
D = A * (1 + A) / 2
E = B * (1 + B) / 2
F = C * (1 + C) / 2

ans = (D * E * F) % 998244353

p ans