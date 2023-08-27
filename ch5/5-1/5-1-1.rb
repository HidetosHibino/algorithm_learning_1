BINGO_GRID_NUM = 3
bingo_card = []

BINGO_GRID_NUM.times do
  bingo_card.append gets.chomp.split(' ').map(&:to_i)
end

bingo_hitted_card = Array.new(BINGO_GRID_NUM) { Array.new(BINGO_GRID_NUM, false) }

lotteries = []

number_of_lotteries = gets.to_i

number_of_lotteries.times do
  lotteries << gets.to_i
end

lotteries.each do |lotterie|
  bingo_card.each_with_index do |inner_array, outer_index|
    inner_array.each_with_index do |number, inner_index|
      if number == lotterie
        bingo_hitted_card[outer_index][inner_index] = true
      end
    end
  end
end

# p "bingo_card: #{bingo_card}"
# p "bingo_hitted_card: #{bingo_hitted_card}"
# p "number_of_lotteries: #{number_of_lotteries}"
# p "lotteries: #{lotteries}"

has_bingo = false

# 横の一致

BINGO_GRID_NUM.times do |index|
  has_bingo = true if bingo_hitted_card[index][0] && bingo_hitted_card[index][1] && bingo_hitted_card[index][2]

  has_bingo = true if bingo_hitted_card[0][index] && bingo_hitted_card[1][index] && bingo_hitted_card[2][index]
end

has_bingo = true if bingo_hitted_card[0][0] && bingo_hitted_card[1][1] && bingo_hitted_card[2][2]

has_bingo = true if bingo_hitted_card[2][0] && bingo_hitted_card[1][1] && bingo_hitted_card[0][2]

p "has_bingo: #{has_bingo}"
