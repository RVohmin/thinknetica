print 'Введите день даты (1-31) '
day = gets.chomp.to_i

print 'Введите месяц даты (1-12) '
month = gets.chomp.to_i

print 'Введите год XXXX '
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# проверка на високосный год
if (year % 4 == 0 && !(year % 100 == 0)) || year % 400 == 0
  months[1] = 29
end

sum_days = day

months.each_with_index do |day_in_month, index|
  if index < month - 1
    sum_days += day_in_month
  end
end

puts "#{sum_days}й день с начала #{year} года"
