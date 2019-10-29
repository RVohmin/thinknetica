# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main
  attr_reader :stations, :trains, :routes
  NUMBER_TRAIN_TEMPLATE = /^\w{3}-*\w{2}$/i

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
          '3. Создать маршрут',
          '4. Назначить маршрут поезду',
          '5. Добавить вагоны к поезду',
          '6. Отцепить вагоны от поезда',
          '7. Переместить поезд по маршруту вперед',
          '8. Переместить поезд по маршруту назад',
          '9. Просмотреть список станций',
          '10. Просмотреть список поездов на станции',
          '11. добавить станцию в маршрут',
          '12. Удалить станцию из маршрута',
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
        move_back
      when 9 then
        show_stations
      when 10 then
        look_trains_on_station
      when 11 then
        add_station
      when 12 then
        del_station
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
        # puts @stations.each { |item| puts item.name }
        break
      else
        puts 'Такая станция уже существует, введите другое название'
      end
    end
  end

  def create_train
    begin
      print 'Введите номер поезда '
      number = gets.chomp
      validate_train!(number)
    rescue StandardError
      puts "Некорректный формат номера или тип поезда. Допустимый формат номера: три буквы или цифры в любом порядке, \n необязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса."
      retry unless valid_train?(number)
    end
    begin
      print 'Введите тип поезда (1 - грузовой, 2 - пассажирский) '
      type = gets.chomp.to_i
      validate_type_train!(type)
    rescue StandardError
      puts 'Тип поезда может быть только 1 (грузовой) или 2(пассажирский)'
      retry unless valid_type?(type)
    end
    if type == 1
      @trains << CargoTrain.new(number)
    elsif type == 2
      @trains << PassengerTrain.new(number)
    end
    puts "поезд #{number} успешно создан #{@trains.last}"
  end

  def validate_train!(number)
    raise StandardError if number.to_s !~ NUMBER_TRAIN_TEMPLATE
  end

  def valid_train?(number)
    validate_train!(number)
    true
  rescue StandardError
    false
  end

  def validate_type_train!(type)
    raise StandardError if type.to_s !~ /[1|2]/
  end

  def valid_type?(type)
    validate_type_train!(type)
    true
  rescue StandardError
    false
  end

  def create_route
    begin
      print 'Введите название маршрута '
      name = gets.chomp.to_s
      validate_route!(name)
    rescue StandardError
      puts 'Имя маршрута от 3 до 10 символов без пробелов'
      retry unless valid_route?(name)
    end
    print 'Введите начальную станцию маршрута '
    start_station = gets.chomp
    unless exist_station?(start_station)
      puts 'Такой станции еще не существует, давайте создадим'
      create_station
    end
    print 'Введите конечную станцию маршрута '
    end_station = gets.chomp
    unless exist_station?(end_station)
      puts 'Такой станции еще не существует, давайте создадим'
      create_station
    end
    @routes << Route.new(name, exist_station?(start_station), exist_station?(end_station))
    puts "Маршрут #{name} создан"
    @routes.each do |item|
      puts item.stations_list
    end

    sleep 1
  end

  def validate_route!(name)
    raise StandardError if name.to_s !~ /\S{3,5}/
  end

  def valid_route?(name)
    validate_route!(name)
    true
  rescue StandardError
    false
  end

  def set_route
    print 'Введите номер поезда, которму Вы хотите назначить маршрут '
    number_train = gets.chomp.to_i
    puts select_train(number_train)
    unless select_train(number_train)
      puts 'Такого поезда нет'
      return
    end
    print 'Введите имя маршрута '
    name_route = gets.chomp
    puts 'Такого маршрута нет' unless select_route(name_route)
    train = select_train(number_train)
    route = select_route(name_route)
    train.get_route(route)
    puts "Маршрут #{name_route} для поезда #{number_train} назначен"
    puts route.name
    puts route
    sleep 1
  end

  def add_wagon
    print 'Введите номер поезда, к которому присоединить вагон '
    number = gets.chomp.to_i
    unless select_train(number)
      puts 'Такого поезда нет'
      return
    end
    train = select_train(number)
    train.set_wagon(CargoWagon.new) if train.type == :cargo
    train.set_wagon(PassengerWagon.new) if train.type == :passenger
    puts 'Вагон добавлен'
  end

  def remove_wagon
    print 'Введите номер поезда, от которого отцепить вагон'
    number = gets.chomp.to_i
    unless select_train(number)
      puts 'такого поезда нет'
      return
    end
    train = select_train(number)
    if !train.wagons.empty?
      train.remove_wagon
      puts 'Вагон отцеплен'
    else
      puts 'У поезда нет вагонов'
    end
  end

  def move_forward
    print 'Какой поезд отправить вперед на одну станцию? '
    number = gets.chomp.to_i
    train = select_train(number)
    if train&.route
      train.go_next
      puts "поезд перемещен на станцию #{train.current_station.name}"
    else
      puts 'Такого поезда нет или у поезда нет маршрута'
      return
    end
  end

  def move_back
    print 'Какой поезд отправить назад на одну станцию? '
    number = gets.chomp.to_i
    train = select_train(number)
    if train&.route
      train.go_prev
      puts "поезд перемещен на станцию #{train.current_station.name}"
    else
      puts 'Такого поезда нет или у поезда нет маршрута'
      return
    end
  end

  def show_stations
    @stations.each_with_index do |item, index|
      puts "#{index + 1}: #{item.name}"
      sleep 0.5
    end
  end

  def look_trains_on_station
    print 'Введите название станции '
    name = gets.chomp
    exist_station?(name).trains_list.each_with_index do |item, index|
      puts "#{index + 1}: поезд № #{item.number_train} тип #{item.type}, вагонов - #{item.wagons.size}"
    end
  end

  def add_station
    print 'Введите имя маршрута, в который добавить станцию '
    name = gets.chomp
    unless route_exist?(name)
      puts 'Нет такого маршрута'
      return
    end
    print 'Введите имя станции '
    name_station = gets.chomp
    unless exist_station?(name_station)
      puts 'Такой станции нет, создайте её сначала'
      return
    end
    station = exist_station?(name_station)
    route_exist?(name).set_way_station(station)
    puts 'Станция добавлена в маршрут '
  end

  def del_station
    print 'Введите имя маршрута,из которого удалить станцию '
    name = gets.chomp
    print 'Введите имя удаляемой станции '
    station = exist_station?(gets.chomp)
    route_exist?(name).delete_station(station) if route_exist?(name)
  end

  def select_train(number_train)
    @trains.each do |item|
      return item if item.number_train == number_train
    end
    false
  end

  def select_route(name)
    @routes.each do |item|
      if item.name == name
        return item
        puts item
      else
        return false
      end
    end
  end

  def route_exist?(name)
    @routes.each do |item|
      return item if item.name == name
    end
    false
  end

  def exist_station?(name)
    @stations.each do |item|
      return item if item.name == name
    end
    false
  end

end

main = Main.new
main.run
