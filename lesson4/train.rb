=begin
Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end
class Train
  attr_reader :speed, :number_cars, :current_station, :next_station, :prev_station

  def initialize(number_train, type_train = :cargo, number_cars)
    @number_train = number_train
    @type_train = type_train
    @number_cars = number_cars
    @speed = 0
  end

  def up_speed(speed = 70)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def set_up_number_cars
    @number_cars += 1 if @speed == 0
  end

  def set_down_number_cars
    @number_cars -= 1 if @speed == 0
  end

  def get_route(route)
    @route = route
    @current_station = route.start_station
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.end_station
  end

  def prev_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.start_station
  end

  def go_next
    @current_station.send_train(self)
    up_speed
    @current_station = next_station if next_station
    stop
    @current_station.set_train(self)
  end

  def go_prev
    @current_station.send_train(self)
    up_speed
    @current_station = prev_station if prev_station
    stop
    @current_station.set_train(self)
  end
end
