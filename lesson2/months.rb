=begin
1. Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы,
у которых количество дней ровно 30
=end

# Месяцы

months = {
    january: 31,
    february: 28,
    march: 31,
    april: 30,
    may: 31,
    june: 30,
    july: 31,
    august: 31,
    september: 30,
    november: 30,
    december: 31
}

months.each {|month, days| puts month if days == 30}
