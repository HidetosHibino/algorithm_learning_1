n = gets.to_i
s = []

n.times do
  s <<  gets.chomp
end

(0..s.length-1-1).reverse_each do |i|
  (1..2*n-2).each do |j|
    if s[i][j] == "#"
      if s[i+1][j-1] == "X"
        s[i][j] = "X"
      end

      if s[i+1][j] == "X"
        s[i][j] = "X"
      end

      if s[i+1][j+1] == "X"
        s[i][j] = "X"
      end
    end
  end
end

s.each { |x| p x }
