# 価値の総和を最大化するのではなく、和をぴったりにできるかを考える。
# これを和の値s それぞれについて　True または Falseで計算していく

# exist[i][s] は問題 1,2, ... i の中からいくつかの問題を解いて、その得点合計がs となる解き方はぞんざいするか？
# 問題i までの解き方を求めて得点合計がs になるケースは

# ・問題 i-1 までの得点合計がs で、問題i を解かない。
# ・問題 i-1 までの合計得点がs-pi で、問題i を解く。

# よって exist[i-1][s] = true もしくは exist[i-1][s-pi] = true であれば、
# exist[i][s] は true　になる。

N = gets.to_i

# 1始まりにするために、先頭にダミーを入れる。
ps = [0] + gets.chomp.split(' ').map(&:to_i)

P = ps.sum

exist = Array.new(N + 1) { Array.new(P + 1, false) }

exist[0][0] = true

p "ps:#{ps}"

(1..N).each do |i|
  (P+1).times do |s|
    # ・問題 i-1 までの得点合計がs で、問題i を解かない。
    exist[i][s] = true if exist[i - 1][s]

    # ・問題 i-1 までの合計得点がs-pi で、問題i を解く
    exist[i][s] = true if s >= ps[i] && exist[i - 1][s - ps[i]]
    # p "i:#{i}, s:#{s}" if s >= ps[i] && exist[i - 1][s - ps[i]]
  end
end

# ans = 0

# exist.each do |e|
#   p e
# end

p (exist[N].select { |x| x }).length
