basket = {}

loop do
  puts 'Введите название товара '
  goods_title = gets.chomp
  break if goods_title == 'стоп' || goods_title == 'stop'

  puts 'Введите цену за единицу товара '
  goods_price = gets.chomp.to_f

  puts 'Введите количество товара '
  goods_number = gets.chomp.to_f

  basket[goods_title] = {price: goods_price, num: goods_number} # формируем общий хеш
end

# считаем цену в корзине
sum_total = 0

basket.each do |title, number|
  puts "В вашей корзине #{number[:num]} товара \"#{title.upcase}\" по цене #{number[:price]}"
  sum = (number[:price] * number[:num]).round(2)
  puts "Общая стоимость #{title} составляет #{sum}"
  sum_total += sum
end

puts "Общая стоимость всех товаров = #{sum_total}"
