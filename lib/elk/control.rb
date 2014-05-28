require File.join File.dirname(__FILE__), 'elk_comm'
require File.join File.dirname(__FILE__), 'output'
require File.join File.dirname(__FILE__), 'outputs'
require File.join File.dirname(__FILE__), 'poller'

module Elk
  class Control
    def initialize(host, port)
      @host = host
      @port = port
      @outputs = Elk::Outputs.new
    end

    def start
      @elk_comm = Elk::ElkComm.new(@host, @port)
      @elk_comm.outputs = @outputs
      @elk_comm.async.run
    end

    def stop
      @elk_comm.terminate
    end

    def to_hex_string(val)
      ("0" + val.to_s(16)).slice(-2,2).upcase
    end

    def m1_checksum(message)
      chk = 0
      message.each_byte{ |b| chk = (chk + b ) }
      # two's compliment
      chk = (-chk & 0xff)#.to_s(16)
      to_hex_string(chk)
    end

    def assemble_message(message)
      m = to_hex_string(message.length + 2) + message
      m + m1_checksum(m)
    end

    def string_number_justify(str, chrs=2)
      str.to_i.to_s.rjust(chrs, '0')
    end

    def send_message_to_elk(message)
      @elk_comm.send_message(message)
      s.puts message
    end

    def task_activation(task_number)
      message = assemble_message "tn#{string_number_justify(task_number, 3)}"
      send_message_to_elk(message)
    end

    def update_outputs_10_munutes
      message = assemble_message "cs00"
      @output_poller = Elk::Poller.new(@elk_comm)
      @output_poller.send_message_for(message, 10*60)
    end
  end
end
