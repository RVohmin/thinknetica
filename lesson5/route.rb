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
  include InstanceCounter
  attr_reader :start_station, :end_station, :stations_list, :name

  def initialize (name, start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations_list = [start_station, end_station]
    @name = name
  end

  def set_way_station(way_station)
    @stations_list.insert(-2, way_station)
  end

  def delete_station(del_station)
    @stations_list.delete_if { |name| name == del_station }
  end
end
