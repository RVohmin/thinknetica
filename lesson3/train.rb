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

  attr_reader :speed, :number_cars, :current_station, :next_station, :prev_station, :route_list

  def initialize(number_train = 123, type_train = :freight, number_cars = 18)
    @number_train = number_train
    @type_train = type_train
    @number_cars = number_cars
    @speed = 0
  end

  def set_up_train_speed(speed)
    @speed = speed
  end

  def set_stop_train
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
    @route_list = route.route_stations
    @current_station = route.start_station
    @next_station = route.next_station
    @prev_station = route.prev_station
    @route_list
  end

  def go_next
    if @current_station != @end_station
      @current_station = @next_station
    end
    puts "Поезд прибыл на станцию #{@current_station}"
  end

  def go_prev
    if @current_station != @start_station
      @current_station = @prev_station
      puts "Поезд прибыл на станцию #{@current_station}"
    else
      puts "Мы на первой станции"
    end
  end

end
