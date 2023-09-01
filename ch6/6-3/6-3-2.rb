h, w = gets.chomp.split(' ').map(&:to_i)

s = []

si, sj = 0
gi, gj = 0

h.times do 
  s << gets.chomp.split('')
end

h.times do |i_h|
  w.times do |i_w|
    if s[i_h][i_w] == 's'
      si = i_h
      sj = i_w
    elsif s[i_h][i_w] == 'g'
      gi = i_h
      gj = i_w
    end
  end
end

visited = Array.new(h) { Array.new(w, false) }

# 変数のスコープゲート越えをしないといけない。 -> visited, h, w, s　等...
# def dfs(i, j)
#   visited[i][j] == true
#   [[i-1, j], [i,j-1], [i+1, j], [i, j+1]].each do |i2, j2|
#     next unless 0 <= i2 && i2 < h && 0 <= j2 && j2 < w

#     next if s[i2][j2] == '#'

#     dfs i2, j2 unless visited[i2][j2]
#   end
# end

define_method :dfs do |i, j|
  visited[i][j] = true
  [[i-1, j], [i,j-1], [i+1, j], [i, j+1]].each do |i2, j2|
    next unless 0 <= i2 && i2 < h && 0 <= j2 && j2 < w

    next if s[i2][j2] == '#'

    dfs i2, j2 unless visited[i2][j2]
  end
end

dfs si, sj
p visited[gi][gj]
