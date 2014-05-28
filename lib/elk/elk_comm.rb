require 'socket'
require 'celluloid'

module Elk
  class ElkComm
    include Celluloid
    finalizer :close
    attr_accessor :interval
    attr_writer :outputs

    def initialize(host, port)
      @host = host
      @port = port
      @queue = Queue.new
      @socket = TCPSocket.open(host, port)
      @interval = 1
    end

    def run
      every(@interval) do
        msg = read_noblock
        process_message(msg) if msg
        send_message

        puts "sleeping (#{@interval}s)..."
        # sleep @interval
      end
    end

    def process_message(msg)
      puts "processing message... #{msg.inspect}"
    end


    def send_message(msg)
      puts "<< adding to queue: #{msg}"
      @queue << msg
    end

    def close
      puts "close: terminate"
      @socket.close if @socket
    end


    private
      def send_message
        unless @queue.empty?
          msg = @queue.pop
          puts ">> sending: #{msg}"
          @socket.puts msg
        end
      end

      def read_noblock
        r,w,e = Kernel.select([@socket], nil, nil, 0)
        puts "select: #{r}, #{w}, #{e}"

        if r
          puts "reading"
          msg = @socket.gets
        end
        msg
      end

  end
end


# ec = Elk::ElkComm.new('desertsol-apps.net', 2101)
# trap("INT") { ec.terminate }
# ec.interval = 2
# ec.async.run

# sleep 10
# ec.send('06cs0064')
# sleep
