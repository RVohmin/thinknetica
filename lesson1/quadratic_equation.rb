=begin
Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D)
и корни уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран.
При этом возможны следующие варианты:
  Если D > 0, то выводим дискриминант и 2 корня
  Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
  Если D < 0, то выводим дискриминант и сообщение "Корней нет"
Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно
использовать Math.sqrt
=end
print 'Введите коэффициент А '
a = gets.chomp.to_f
print 'Введите коэффициент В '
b = gets.chomp.to_f
print 'Введите коэффициент С '
c= gets.chomp.to_f

discriminant = (b ** 2) - (4 * a * c)
x1 = (-b + Math.sqrt(discriminant) / (2 * a))
x2 = (-b - Math.sqrt(discriminant) / (2 * a))

if discriminant < 0
  puts "Корней нет"
elsif discriminant == 0
  puts "Дискриминант = #{discriminant}"
  puts "Корень уравнения равен #{x1}"
elsif discriminant > 0
  puts "Дискриминант = #{discriminant}"
  puts "1й Корень уравнения равен #{x1}"
  puts "2й Корень уравнения равен #{x2}"
end
