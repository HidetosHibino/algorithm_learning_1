N = gets.to_i

# X[d]: d日目から実行可能になるタスクのポイントを集めた配列
X=[]

N.times do
  X << []
end


N.times do
  a, b = gets.chomp.split(' ').map(&:to_i)
  X[a - 1] << b
end

cnt = [0] * 101
ans = 0

N.times do |d|
  # d日目から可能になるタスクをcnt に追加する
  X[d].each do |b|
    cnt[b] += 1
  end

  100.step(0, -1) do |b|
    # value が高い順に見ていく。 value = b の件数が1以上なら実行する。
    if cnt[b] > 0
      ans += b
      cnt[b] -= 1
      # 1日に1タスクなので、検索終了
      break
    end
  end

  p ans
end

