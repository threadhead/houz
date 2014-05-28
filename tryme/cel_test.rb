# require 'bundler/setup'
require 'celluloid/io'

class HouzServer
  include Celluloid::IO
  finalizer :finalize

  def initialize(host, port)
    puts "*** Listening on #{host}:#{port}"

    # Since we included Celluloid::IO, we're actually making a
    # Celluloid::IO::TCPServer here
    @server = TCPSocket.open(host, port)
    async.run
  end

  def finalize
    puts "*** finalize"
    @server.close if @server
  end

  def run
    puts "   run loop"
    loop do
      puts "   -> reading"
      r = @server.readpartial(4096)
      puts "   -> got: #{r.inspect}" unless r.empty?
    end
  end

  # def run
  #   puts "   run loop"
  #   loop { async.handle_connection @server.accept }
  # end

  def handle_connection(socket)
    # _, port, host = socket.peeraddr
    puts "   -> reading from port loop"
    # loop { socket.write socket.readpartial(4096) }
    loop do
      r = socket.readpartial(4096)
      puts r.inspect
    end
  rescue EOFError
    puts "*** #{host}:#{port} disconnected"
    socket.close
  end
end

supervisor = HouzServer.supervise("192.168.0.6", 2101)
trap("INT") { supervisor.terminate; exit }
sleep
