require 'socket'

s = TCPSocket.open '192.168.0.6', 2101
while true
  # r = s.read_nonblock(4096)

  begin
    puts 'begin read_nonblock'
    r = s.read_nonblock(4096)
    puts 'end read_nonblock'

  rescue IO::WaitReadable
    puts 'rescue: retry'
    # IO.select([s])
    sleep 1
    retry
  end

  puts "read: #{r.inspect}"
  sleep 1
end
# puts "nonblock: #{s.nonblock?}"
s.close
