n = gets.to_i

h = gets.chomp.split(' ').map(&:to_i)

# cost[i]: 足場i にたどり着くための最小コスト。　サイズNを確保する。
cost = [0] * n

# 初期条件: 足場1
cost[0] = 0

# 2つ目の足場へは１通りしかない
cost[1] = cost[0] + (h[0] - h[1]).abs

(2..n-1).each do |i|
  cost[i] = [cost[i-1] + (h[i-1] - h[i]).abs, cost[i-2] + (h[i-2] - h[i]).abs].min
end

p cost[n-1]
