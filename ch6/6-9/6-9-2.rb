A, B, X = gets.chomp.split(' ').map(&:to_i)

ok = 0
ng = 10**9 + 1

while (ok - ng).abs > 1
  mid = (ok + ng) / 2
  d = mid.to_s.length
  price = A * mid + B * d
  if price <= X
    ok = mid
  else
    ng = mid
  end
end

p ok
