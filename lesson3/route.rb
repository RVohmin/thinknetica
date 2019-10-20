=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся
при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной

При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Route

  attr_reader :start_station, :end_station, :current_station, :prev_station, :next_station

  def initialize (start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @route_stations = [start_station, end_station]
    @current_station = start_station
    @next_station = end_station
  end

  def rout_list
    @route_stations.each { |station| puts station }
  end

  def set_way_station(way_station)
    @route_stations.insert(-2, way_station)
    puts "Станция добавлена в маршрут, теперь маршрут такой: #{@route_stations}"
  end

  def next_station
    @next_station = @route_stations[@current_station.index(@current_station) + 1]
  end

  def prev_station
    if @current_station != @start_station
      @next_station = @route_stations[@current_station.index(@current_station) - 1]
    end
  end

  def delete_station(del_station)
    @route_stations.delete_if { |name| name == del_station }
    puts "Станция удалена из маршрута, теперь маршрут такой: #{@route_stations}"
  end

end
