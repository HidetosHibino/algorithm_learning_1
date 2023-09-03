# cost[i][j] = i 文字目までの扱いを決め終わって、先頭からその文字までの累積和がj であるときに、
# それまで使った操作コストの最小値。
# ただし、i 文字目までの間に条件違反、がないものとする。

# cost[i-1][j] からの遷移を考えたとき、以下の3パターン
# そのまま使う: コストがそのままで、cost[i][j+i]に遷移する。
# 反転させる: コストがCi増加して、cost[i][j-1]に遷移する。
# 削除する: コストがDi増加して、cost[i][j]に遷移する。

# もし、Si が) だった場合が、「そのまま使う」と「反転させる」の遷移における新しいj の値が逆になる。
# そして終点までの累積和は0 である必要があるため、最終的に cost[N][0]

N = gets.to_i

# インデックスを1始まりにするため、先頭にダミー要素を入れる。
s = " #{gets.chomp}"

C = [0] + gets.chomp.split(' ').map(&:to_i)

D = [0] + gets.chomp.split(' ').map(&:to_i)

INF = 10**2

# cost[i][j]: i文字目までの扱いを決めて、そこまでの累積和がj であるときのコスト最小値
cost = []

(N + 1).times { cost << [INF] * (N + 1) }

cost[0][0] = 0

(1...N+1).each do |i|
  i.times do |j|
    if s[i] == '('
      # そのまま使う
      cost[i][j+1] = [cost[i][j+1], cost[i-1][j]].min
      # 反転させる
      if j > 0
        cost[i][j-1] = [cost[i][j-1], cost[i-1][j] + C[i]].min
      end
    else
      # そのまま使う
      if j > 0
        cost[i][j-1] = [cost[i][j-1], cost[i-1][j]].min
      end
      # 反転させる
      cost[i][j+1] = [cost[i][j+1], cost[i-1][j] + C[i]].min
    end
    cost[i][j] = [cost[i][j], cost[i-1][j] + D[i]].min
  end
  # p "=============="
  # cost.each do |row|
  #   p row
  # end
end

p cost[N][0]
