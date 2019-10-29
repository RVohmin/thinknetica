=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  include InstanceCounter
  attr_reader :name, :trains_list
  @@stations = []

  def self.all
    puts "Всего #{@@stations.size} станций"
    @@stations.each_with_index do |item, index|
      puts "#{index + 1}: станция #{item.name} #{item}"
    end
  end

  def initialize(name)
    @name = name
    @trains_list = []
    @@stations << self
    # puts "!!!!!!!!!!!!!!!!!#{register_instance}"
  end

  def set_train(train)
    @trains_list << train
  end

  def get_type_trains(type)
    @trains_list.select { |train| train.type == type }
  end

  def send_train(train)
    @trains_list.delete(train)
  end
end

