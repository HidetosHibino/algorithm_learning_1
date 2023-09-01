# 整数N以下の数字のうち、753数はいくつあるか。

@max = gets.to_i

@ans = 0

def dfs(n, b_3, b_5, b_7)
  if n > @max
    return 
  end

  if b_3 && b_5 && b_7
    @ans += 1
  end

  # 10倍して n を足す（１の桁を足す発想）
  # 頭の桁に足すのは思いついたけど、こっちの方が楽
  dfs(10 * n + 3, true, b_5, b_7)
  dfs(10 * n + 5, b_3, true, b_7)
  dfs(10 * n + 7, b_3, b_5, true)
end

dfs(0, false, false, false)

p @ans
