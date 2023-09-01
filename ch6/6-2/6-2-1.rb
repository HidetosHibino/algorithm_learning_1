n = gets.to_i
c = gets.chomp.split(' ').map(&:to_i)
q = gets.to_i

# それぞれのカード枚数は、単品注文の時のみ、配列で管理する。
# 複数注文時は、その枚数を記録しておき、
# z と s を使って管理する。
# a 枚売れるかの判定は、対象をループして全検索するのではなく、
# それぞれの条件での最小値を保持しておき、そこからa 枚出せるか? で判定する

# 合計販売枚数を記録する変数
sell = 0

# 全集類販売で販売した1種類あたりの枚数
z = 0

# セット販売で販売した1種類あたりの枚数
s = 0

# セット販売対象のCの最小値を記録する変数
min_s_c = 1000000000

# セット販売対象でないCの最小値を記録する変数
min_z_c = 1000000000

n.times do |i|
  if i % 2 == 0
    min_s_c = ( min_s_c > c[i] ? c[i] : min_s_c )
  else
    min_z_c = ( min_z_c > c[i] ? c[i] : min_z_c )
  end
end

q.times do
  query = gets.chomp.split(' ').map(&:to_i)

  # 単品販売
  if query[0] == 1
    x = query[1] - 1
    a = query[2]

    card_x = 0

    if x % 2 == 0
      card_x = c[x] - z - s
    else
      card_x = c[x] -z
    end

    if card_x >= a
      c[x] -= a
      sell += a

      if x % 2 == 0
        min_s_c = ( min_s_c > c[x] ? c[x] : min_s_c )
      else
        min_z_c = ( min_z_c > c[x] ? c[x] : min_z_c )
      end
    end
  end

  # セット販売
  if query[0] == 2
    a = query[1]
    s += a if min_s_c - s - z >= a
  end

  # 全種販売
  if query[0] == 3
    a = query[1]
    # min_s_c と min_z_c は別で管理しているので、それぞれで行けるかチェック 
    z += a if min_z_c - z >= a && min_s_c - s - z >= a
  end
end

# セット販売分を加算
n.times do |j|
  sell += s if j % 2 == 0
end

# 全種類を加算
sell += z * n

p sell
