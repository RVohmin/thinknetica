# 2. Заполнить массив числами от 10 до 100 с шагом 5
arr = []
index = 10

while index <= 100 do
  arr = arr.push(index)
  index += 5
end

puts arr

