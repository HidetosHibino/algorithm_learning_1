# N 個の都市 0,1,2, ... N-1
# 都市iから都市j に移動する時のコストはA(i,j) である

# すでに訪れたことのある都市の状態を持つが、都市0は始点と終点で両方訪れるため、スタート時点では集合に含めず、ゴールしたときに集合に含める。
# cost[n][i]: すでに訪れた都市の集合がn であって、最後にいる都市がi である時の、合計コストの最小値

# 初期状態は、始点を全体n に含めないことに認め cost[0][0] = 0 で、遷移時は次のどこを訪れるのかを全通り試す。
# この時、すでに訪れた都市には行かないようにする。

# 次に訪れる都市をj とすると、訪れた都市の集合にj が追加され、最後にいる都市がj になるため、
# cost[n|(i<<j)][j]になる 状態n の時に、j に行く→ 状態n と状態j(jに行ったを示す 2^j) を足す(論理和をとる) 

N = gets.to_i

A = []

N.times do |i|
  A << gets.chomp.split(' ').map(&:to_i)
end

p A

ALL = 1 << N

# cost[n][i]: 訪れた都市の集合がnで、最後にいる都市がi であるときのコスト最小
cost = []
ALL.times do |i|
  cost << [10**4] * N
  # cost << [10**100] * N
end

cost[0][0] = 0
# nで表される状態に 要素i が含まれているかを判定
def has_bit(n, i)
  n & (1<<i) > 0
end

ALL.times do |n|
  N.times do |i|
    # i から j への遷移を試す
    N.times do |j|
      next if has_bit(n, j) || i == j

      cost[n|(1<<j)][j] = [cost[n|(1<<j)][j], cost[n][i] + A[i][j]].min
    end
  end
end

# cost.each do |c|
#   p c
# end
p cost[ALL-1][0]
