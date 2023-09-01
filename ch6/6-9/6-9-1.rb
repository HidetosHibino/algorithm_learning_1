# ２分探索法

# 初期のNGとOK については Nと-1を使う
# N個の配列A について a1 = A[0]、 an = A[n-1] であり、 N, -1 は配列の外に存在するためアクセスできないが、添字との比較は可能。
# また、最初に N, -1については NG, OKを設定するので、アクセスして確認する必要はない。

N, K = gets.chomp.split(' ').map(&:to_i)
A =  gets.chomp.split(' ').map(&:to_i)

ok = N
ng = -1

while (ok-ng).abs > 1
  mid = (ok + ng) / 2
  if A[mid] >= K
    ok = mid
  else
    ng = mid
  end
end

if ok == N
  p -1
else
  p ok
end
