require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_wagon'

class Menu

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def create_station
    print 'Введите название станции '
    loop do
      name = gets.chomp
      if stations.include?(name)
        print 'Такая станция уже есть, введите другое название: '
      else
        @stations << Station.new(name)
        puts "Станция #{name} успешно создана"
        break
      end
    end
  end
  main_menu = [
      '1. Создать станцию',
      '2. Создать поезд',
      '3. Создать маршрут и управлять станциями в нем (добавить, удалить станцию)',
      '4. Назначить маршрут поезду',
      '5. Добавить вагоны к поезду',
      '6. Отцепить вагоны от поезда',
      '7. Переместить поезд по маршруту вперед',
      '8. Просмотреть список станций и поездов на станции'
  ]
  main_menu.each { |item| puts item }

  puts
  puts 'Что Вы хотите сделать? '

  case (gets.chomp.to_i)
  when 1 then create_station
  when 2 then create_train
  when 3 then create_route
  when 4 then set_route
  when 5 then add_wagon
  when 6 then remove_wagon
  when 7 then move_forward
  when 8 then look_station
  end

end

Menu.new
