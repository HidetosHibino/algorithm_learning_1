str_s = gets.chomp

def is_match?(str_t, str_s)
  (0..(str_s.length - str_t.length + 1 - 1)).each do |i|
    is_ok = true
    # 文字列Tのj文字目と、文字列Sのi + j文字目を比べる。
    (0..str_t.length - 1).each do |j|
      is_ok = false if str_s[i + j] != str_t[j] && str_t[j] != '.'
      # breackで抜けてもいいのでは？
    end
    return true if is_ok
  end
  false
end

t = 'abcdefghijklmnopqrstuvwxyz.'

# マッチした文字列を保持する配列。
m = []

t.chars.each do |c1|
  m << c1 if is_match? c1, str_s

  t.chars.each do |c2|
    str_v1 = c1 + c2
    m << str_v1 if is_match? str_v1, str_s

    t.chars.each do |c3|
      str_v2 = str_v1 + c3
      m << str_v2 if is_match? str_v2, str_s
    end
  end
end

p m.length
