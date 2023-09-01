N = gets.to_i

# # 愚直な実装
# # これは O(N^3)

# ans = 0
# (1...N).each do |a|
#   (1...N).each do |b|
#     (1...N).each do |c|
#       ans += 1 if a * b + c == N
#     end
#   end
# end

# p ans

# ループを減らす考察
# A*B+C = N が成り立つ C は C =N-A*B の1つしかない。
# このCが正の整数であれば、問題文の条件を満たすため、解答としてカウントできる。
# よって C について1~ N-1 までループする必要はない
# これは O(N^2)

# ans = 0
# (1...N).each do |a|
#   (1...N).each do |b|
#     # (1...N).each do |c|
#     #   ans += 1 if a * b + c == N
#     # end
#     c =  N - (a * b)
#     ans += 1 if c > 0
#   end
# end

# p ans

# # 計算を省略する考察
# # c =  N - (a * b)
# # ans += 1 if c > 0
# # について、 N > (a * b) である。
# # ここで、b について N > (a * b(n))である時、それより大きいb(b(n+m)) についても成り立たないといえる。
# # 従って、N > (a * b(n))　であった時点でループを抜けても良い。
# # この場合、 N + N/2  + N/3 + N/4 ... + n/n でこれは N logN 

# ans = 0
# (1...N).each do |a|
#   (1...N).each do |b|
#     # c =  N - (a * b)
#     # ans += 1 if c > 0
#     # p "#{a} * #{b} >= #{N} is true"  if (a * b) >= N
#     break if (a * b) >= N

#     ans += 1
#   end
# end

# p ans

# ループを減らす考察２
# Aを固定したとき、Bを試すループは、 N > A * B を満たすB だけ繰り返す。
# このループ数はAを固定した時に決まる。
# なので、ループせずに、ループする回数だけ、ans に足すことができればいい。
# N > A+B 
# 1 =< B =< (N-1)/A を満たすBの数
# この場合は、Aに1~ N-1 を入れるため、 O(N)

ans = 0
(1...N).each do |a|
  ans += (N-1)/a
end

p ans
