n, m, q = gets.chomp.split(' ').map(&:to_i)

# false の n * n の 配列を作る
graph = Array.new(n) { Array.new(n, false) }

(0..m-1).each do |i|
  u, v = gets.chomp.split(' ').map { |x| x.to_i - 1 }
  graph[u][v] = true
  # 逆からの視点も忘れない。
  graph[v][u] = true
end

c = gets.chomp.split(' ').map(&:to_i)

q.times do |i|
  # query は 2この場合も、３個の場合もあるので、arrayで受ける。
  query = gets.chomp.split(' ').map(&:to_i)
  # １の場合、query[1]の色を返す。
  if query[0] == 1
    x = query[1] - 1
    puts c[x]

    # query[1] に隣接しているものは塗る。
    # -> 隣接行列を確認する。
    # query[1]行目 についてなので、graph[query[1]-1][ n ] がtrueかどうか
    n.times do |i|
      c[i] = c[x] if graph[x][i]
    end
  end

  if query[0] == 2
    x = query[1] - 1
    y = query[2]

    puts c[x]

    c[x] = y
  end
end
