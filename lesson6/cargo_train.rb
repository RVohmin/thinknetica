class CargoTrain < Train
  def initialize(number_train)
    super
    @type = :cargo
  end
end
