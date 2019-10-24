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
  attr_reader :speed, :current_station, :next_station, :prev_station, :type, :number_train, :wagons, :route

  def initialize(number_train)
    @number_train = number_train
    @speed = 0
    @wagons = []
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
