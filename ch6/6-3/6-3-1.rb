r, c = gets.chomp.split(' ').map(&:to_i)
sy, sx =  gets.chomp.split(' ').map { |x| x.to_i - 1 }
gy, gx =  gets.chomp.split(' ').map { |x| x.to_i - 1 }

s = []

r.times do
  s << gets.chomp.split('')
end

# 始点からの最小移動回数を管理する２次元配列。　-1 であれば未訪問
dist = Array.new(r) { Array.new(c, -1) }

q = []

# q は 座標情報[y, x] を保持
q << [sy, sx]
dist[sy][sx] = 0

while q.length > 0 do
  i, j = q.shift # q は座標情報[y, x]
  # 上下左右のマスを確認
  [[i - 1, j], [i + 1, j], [i, j - 1], [i , j + 1]].each do |i2, j2|
    next unless (0 <= i2 && i2 <= r - 1) && (0 <= j2 && j2 <= c - 1)

    # p s[i2, j2]
    next if s[i2][j2] == '#'

    # もし未訪問であれば(dist[i2][j2] = -1)キューに追加、距離更新
    if dist[i2][j2] == -1
      q << [i2, j2]
      dist[i2][j2] = dist[i][j] + 1
    end
  end
end

# dist.map { |ary| p ary}
p dist[gy][gx]
