module Elk
  class Output
    attr_reader :value, :number

    def initialize(number, val)
      @number = number
      self.value = val
    end

    def value=(val)
      @value = val == "1"
    end
  end
end
