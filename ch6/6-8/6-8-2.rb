# タスクをその終了日が早いものから順に並ぶようにソートする。
# ソートしたタスクを順番に見ていく。見ているタスクがもし実行可能であるならば、そのタスクを採用する。

N = gets.to_i
# 終了日でソートするため。[終了日, 開始日]の順に格納する。
BA = []
N.times do |i|
  a, b = gets.chomp.split(' ').map(&:to_i)
  BA << [b, a]

  BA.sort!
end

ans = 0
last = 0

BA.each do |b, a|
  if last < a
    ans += 1
    last = b
  end
end

p ans
