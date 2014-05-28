module Elk
  class Outputs
    attr_reader :outputs

    def initialize
      @outputs = Array.new(212) { |i| Elk::Output.new(i+1, '0') }
    end

    def value(output_number)
      @outputs[output_number-1].value
    end

    def number(output_number)
      @outputs[output_number-1].number
    end

    def set_state(output_number, state)
      @outputs[output_number-1].value = state
    end

    def set_state_elk_string(str)
      arr = str.split('')
      arr.each_with_index { |output_number, idx| set_state(idx+1, output_number)}
    end
  end
end
