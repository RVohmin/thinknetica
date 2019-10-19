# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('а'..'я').to_a
vowels = ['а', 'е', 'и', 'й', 'о', 'у', 'ы', 'э', 'ю', 'я']
hash_vowels = {}

alphabet.each_with_index do |letter, index|
  if vowels.include?(letter)
    hash_vowels[letter] = index + 1
  end
end

puts hash_vowels
