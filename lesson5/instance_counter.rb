module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :count_class
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.count_class = 0 if self.class.count_class.nil?
      self.class.count_class += 1
    end
  end
end
