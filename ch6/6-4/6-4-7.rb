N = gets.to_i

# child[i]: 頂点i の子(部下) となる頂点たち
@child = []

N.times do
  @child << []
end

(1...N).each do |i|
  b = gets.to_i
  p "b:#{b} i:#{i}"
  @child[b - 1] << i
end

def dfs(i)
  # 子がいなければ 1
  if @child[i].length == 0
    1
  else
    # values を求めるために 子に聞く
    values = []
    @child[i].each do |c|
      values << dfs(c)
    end

    values.max + values.min + 1
  end
end

# p @child
p dfs(0)
