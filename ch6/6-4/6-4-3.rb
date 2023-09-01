# メモ化

n = gets.to_i
h = gets.chomp.split(' ').map(&:to_i)

# 
cost = [0] * n

done = [false] * n

# def rec(i)
#   return cost[i] if done[i]

#   if i == 0
#     cost[i] == 0 
#   elsif i == 1
#     cost[1] == rec(0) + (h[0] - h[1]).abs
#   else
#     cost[i] == [rec(i - 1) + (h[i - 1] - h[i]).abs, rec(i - 2) + (h[i - 2] - h[i]).abs].min
#   end

#   done[i] = true

#   return cost[i]
# end

define_method :rec do |i|
  return cost[i] if done[i]

  if i == 0
    cost[i] = 0 
  elsif i == 1
    cost[1] = rec(0) + (h[0] - h[1]).abs
  else
    cost[i] = [rec(i - 1) + (h[i - 1] - h[i]).abs, rec(i - 2) + (h[i - 2] - h[i]).abs].min
  end

  done[i] = true

  return cost[i]
end

puts rec(n - 1)
