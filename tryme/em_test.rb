require 'eventmachine'
require 'thread'

def other_things
  # puts "Main: #{Thread.current}"
  puts "I"
  sleep 0.2
  puts "can"
  sleep 0.2
  puts "do"
  sleep 0.2
  puts "other"
  sleep 0.2
  puts "things"
end

class Echo < EM::Connection
  def initialize(host, port)
    @host, @port = host, port
    puts "initialize host: #{host}, port: #{port}"
  end

  def receive_data(data)
    puts "  receive_data"
    # puts "  receive data thread: #{Thread.current}"
    puts data
    EM.stop
  end

  def unbind
    puts 'unbind'
    reconnect @host, @port
  end
end

operation = Proc.new do
  host = '192.168.0.6'
  # host = 'desertsol-apps.net'
  port = 2101

  puts "  in operation"
  # puts "  operation thread: #{Thread.current}"
  puts "  before em.connect #{Time.now}"
  EM.connect(host, port, Echo, host, port)
  puts "  after em.connect: #{Time.now}"
end

callback = Proc.new do
  puts "  in the callback"
  # puts "  callback thread: #{Thread.current}"
end

EM.run do
  # EM.add_timer(2) do
    puts "add periodic timer (2)"
    EM.defer(operation, callback)
    puts "  defer called"
    other_things
  # end
end


# EM.run do
#   EM.defer do
#     EM.connect("192.168.0.6", 2101, Echo)
#   end
# end



# EM.run do
#   p = EM::PeriodicTimer.new(1) do
#     puts "Tick ..."
#   end

#   EM::Timer.new(5) do
#     puts "BOOM"
#     p.cancel
#   end

#   EM::Timer.new(8) do
#     puts "The googles, they do nothing"
#     EM.stop
#   end
# end
