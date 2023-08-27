k = gets.to_i

a, b = gets.chomp.split(' ').map(&:to_i)

result = false

n = a / k
m = b / k

if n < m
  result = true
end

if (a % k).zero?
  result = true
end

p result
# a = n * k + y
# b = m * k + z
# である時、 n < m であるならば、k の倍数は n と m の間に存在するといえる。

# なぜなら、
# a = n * k + y
# b = m * k + z
# であり、 n < m ならば、 
# m - n = L とした場合、 L > 1 である。
# この時、
# b = m * k + z は
# b = ( L + n ) * K + z 
# である。

# L > 1 
# なので、
# n * k + y =< n (k+1) =< ( L + n ) * K + z である。
# # L > 1 なので、
# # ( L + n ) * K + z  >= n ( k + 1 ) である。

# n * k + y =< n (k+1) =< ( L + n ) * K + z ゆえに、
# a =< n ( k + 1 ) =< bであるため、
# a = n * k + y
# b = m * k + z
# で n < m であるならば、k の倍数は n と m の間に存在するといえる。
