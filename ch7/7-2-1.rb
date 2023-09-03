N, M = gets.chomp.split(' ').map(&:to_i)
A =  gets.chomp.split(' ').map(&:to_i)

# B[k] 子供kが食べた寿司の美味しさ最大値の -1
B = [0] * N

A.each do |a|
  k = B.bsearch_index { |x| a > x }
  if k.nil?
    p -1
  else
    p k + 1
    B[k] = a
  end
end
