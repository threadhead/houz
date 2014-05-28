require 'celluloid'

module Elk
  class Poller
    include Celluloid

    attr_reader :running

    def initialize(elk_comm)
      @elk_comm = elk_comm
      @running = false
    end


    def send_message_for(message, duration=5*60, interval=1)
      tin = Time.now
      @running = true
      while(Time.now - tin < duration) do
        after(interval) do
          puts "elkcomm: #{@elk_comm.inspect}"
          @elk_comm.send_message(message)
        end
      end
      @running = false
    end


    def send_indefinitely(message, interval=1)
      @running = true
      every(interval) do
        @elk_comm.send_message(message)
      end
      @running = false
    end

  end
end
