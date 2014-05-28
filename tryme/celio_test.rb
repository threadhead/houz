require 'celluloid'
require 'celluloid/io'

class MyPoll
  include Celluloid::IO
  finalizer :shutdown

  def initialize
    @socket = TCPSocket.open('desertsol-apps.net', 2101)
  end

  def reader
    r = @socket.read
    puts "socket read: #{r.inspect}"
  end

  def shutdown
    @socket.close if @socket
  end
end


class MyLooper
  include Celluloid

  def run
    @socket = MyPoll.new
    loop do
      @socket.reader
      puts 'doing other stuff...'
    end
  end
  def term
    @socket.terminate
  end
end

sup = MyLooper.new
trap("INT") { sup.term; exit }
sup.async.run
sleep
