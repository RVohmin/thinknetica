# 3. Заполнить массив числами фибоначчи до 100

fibo = [0, 1]

loop do
  fibo_next = fibo.last + fibo[-2]
  break if fibo_next > 100
  fibo << fibo_next
end

puts fibo
