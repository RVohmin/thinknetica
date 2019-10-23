require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_wagon'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def run
    loop do
      main_menu = [
          '1. Создать станцию',
          '2. Создать поезд',
          '3. Создать маршрут и управлять станциями в нем (добавить, удалить станцию)',
          '4. Назначить маршрут поезду',
          '5. Добавить вагоны к поезду',
          '6. Отцепить вагоны от поезда',
          '7. Переместить поезд по маршруту вперед',
          '8. Просмотреть список станций и поездов на станции',
          '0 - выход из меню'
      ]
      main_menu.each { |item| puts item }

      puts
      print 'Что Вы хотите сделать? '

      case (gets.chomp.to_i)
      when 1 then
        create_station
      when 2 then
        create_train
      when 3 then
        create_route
      when 4 then
        set_route
      when 5 then
        add_wagon
      when 6 then
        remove_wagon
      when 7 then
        move_forward
      when 8 then
        look_station
      else
        puts 'До свидания'
        break
      end
    end
  end


  def create_station
    loop do
      print 'Введите название станции '
      name = gets.chomp
      if !exist_station?(name)
        @stations << Station.new(name)
        puts "Станция #{name} успешно создана"
        break
      else
        puts 'Такая станция уже существует, введите другое название'
      end
    end
  end

  def exist_station?(name)
    @stations.each do |item|
      if item.name == name
        return true
      end
    end
    return false
  end

  def create_train
    print 'Введите номер поезда '
    number = gets.chomp.to_i
    print 'Введите тип поезда (1 - грузовой, 2 - пассажирский) '
    type = gets.chomp.to_i == 1 ? @trains << CargoTrain.new(number) : @trains << PassengerTrain.new(number)
    puts "поезд #{number} успешно создан"
  end

  def create_route
    print 'Введите название маршрута '
    name = gets.chomp.to_s
    print 'Введите начальную станцию '
    start_station = gets.chomp
    print 'Введите конечную станцию '
    end_station = gets.chomp
    @routes << Route.new(name, start_station, end_station)
    puts "Маршрут #{name} создан"
    sleep 3
  end

  def set_route
    print 'Введите номер поезда, которму Вы хотите назначить маршрут'
    number_train = gets.chomp.to_i
    print 'Введите имя маршрута'
    name_route = gets.chomp
    train = select_train(number_train)
    route = select_route(name_route)
    train.get_route(route)
    puts "Маршрут #{name_route} для поезда #{number_train} назначен"
    sleep 2
  end

  def select_train(number_train)
    @trains.each do |item|
      if item.number_train == number_train
        return item
      end
    end
  end

  def select_route(name)
    @routes.each do |item|
      if item.name == name
        return item
      end
    end
  end

end

main = Main.new
main.run
