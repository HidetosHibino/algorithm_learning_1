n, m, q = gets.chomp.split(' ').map(&:to_i)

# false の n * 0 の 配列を作る
graph = Array.new(n, [])

# 本の辺を受け取る
m.times do |i|
  u, v = gets.chomp.split(' ').map { |x| x.to_i - 1 }
  graph[u] << v
  # 逆も忘れない
  graph[v] << u
end

# 頂点のリストを受け取る
c = gets.chomp.split(' ').map(&:to_i)

q.times do |i|
  query = gets.chomp.split(' ').map(&:to_i)

  if query[0] == 1
    x = query[1] - 1
    puts c[x]
    graph[x].each do |num|
      c[num] = c[x]
    end
  end

  if query[0] == 2
    x = query[1] - 1
    y = query[2]
    puts c[x]
    c[x] = y
  end
end