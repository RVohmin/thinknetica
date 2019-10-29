# Реализовать проверку (валидацию) данных для всех классов. Проверять основные атрибуты (название, номер, тип и т.п.) на наличие, длину
# и т.п. (в зависимости от атрибута):
#       - Валидация должна вызываться при создании объекта, если объект невалидный, то должно выбрасываться исключение
#       - Должен быть метод valid? который возвращает true, если объект валидный и false - в противном случае.
# Релизовать проверку на формат номера поезда. Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис (может быть,
# а может нет) и еще 2 буквы или цифры после дефиса.
# Убрать из классов все puts (кроме методов, которые и должны что-то выводить на экран), методы просто возвращают значения.
# (Начинаем бороться за чистоту кода).
# Релизовать простой текстовый интерфейс для создания поездов (если у вас уже реализован интерфейс, то дополнить его):
#     - Программа запрашивает у пользователя данные для создания поезда (номер и другие необходимые атрибуты)
#     - Если атрибуты валидные, то выводим информацию о том, что создан такой-то поезд
#      - Если введенные данные невалидные, то программа должна вывести сообщение о возникших ошибках и заново запросить данные у пользователя. Реализовать это через механизм обработки исключений

class Train
  include InstanceCounter
  include Manufacturer
  attr_reader :speed, :current_station, :type, :number_train, :wagons, :route

  @@trains_list = {}

  def self.find(number_train)
    @@trains_list[number_train]
  end

  def initialize(number_train)
    @number_train = number_train
    @speed = 0
    @wagons = []
    @@trains_list[number_train] = self
    @@num = number_train
  end

  def get_route(route)
    @route = route
    @current_station = route.start_station
    @current_station_index = 0
    @current_station.set_train(self)
  end

  def set_wagon(wagon)
    @wagons << wagon if @speed == 0
  end

  def remove_wagon
    @wagons.delete(-1) if @speed == 0 && !wagons.empty?
  end

  def next_station
    @route.stations_list[@current_station_index + 1] if @current_station != @route.end_station
  end

  def prev_station
    @route.stations_list[@current_station_index - 1] if @current_station != @route.start_station
  end

  def go_next
    @current_station.send_train(self)
    up_speed
    @current_station = next_station if next_station
    stop
    @current_station.set_train(self)
    @current_station_index += 1
  end

  def go_prev
    @current_station.send_train(self)
    up_speed
    @current_station = prev_station if prev_station
    stop
    @current_station.set_train(self)
    @current_station_index -= 1
  end

  private

  def up_speed(speed = 70)
    @speed = speed
  end

  def stop
    @speed = 0
  end

end
