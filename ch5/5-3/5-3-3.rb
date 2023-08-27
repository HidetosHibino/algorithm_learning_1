# N人
# ログはQ行
# 文字列はSi 
# Si は以下のどれか
# 1 a b :フォロー        -> aがbをフォロー
# 2 a   :フォロー全返し   -> a が aをフォローしているすべてをフォロー
# 3 a   :フォローフォロー -> a がフォローしている各ユーザーX について、ユーザーXがフォローしている全ユーザー(ただし aを除く)をaがフォローする。

# N Q
# s1
# ...
# sq

n, q = gets.chomp.split(' ').map(&:to_i)

graph = Array.new(n) { Array.new(n, false) }

q.times do
  query = gets.chomp.split(' ').map(&:to_i)

  if query[0] == 1
    a, b = (query.slice 1..2).map { |x| x - 1 }
    graph[a][b] = true
  end

  if query[0] == 2
    a = query[1] - 1
    n.times do |i|
      p "q:2, a:#{a}, i:#{i}"
      graph[a][i] = true if graph[i][a]
    end
  end

  if query[0] == 3
    a = query[1] - 1
    to_follow = []

    n.times do |x|
      # a が フォローしているか？
      if graph[a][x]
        graph[x].length.times do |i|
          # x のフォローについて、a ではなければ、それをフォロー
          if graph[x][i] && i != a
            to_follow << i
          end
        end
      end
    end

    to_follow.each do |f|
      graph[a][f] = true
    end
  end
end

graph.each do |row|
  # row.each do |is_follow|
  #   p is_follow ? 'Y' : 'N'
  # end
  # p (row.each { |is_follow| is_follow ? 'Y' : 'N' })
  p (row.map { |x| x ? 'Y' : 'N' }).join('')
end
