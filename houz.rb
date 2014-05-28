require 'rubygems'
require 'dotenv'
Dotenv.load

require 'sinatra'
require 'haml'
require 'socket'
require File.join(File.dirname(__FILE__), 'lib', 'elk', 'control')

if ENV['USERNAME'] && ENV['PASSWORD']
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    sleep 0.5
    if username == ENV['USERNAME'] and password == ENV['PASSWORD']
      true
    else
      # log attempt
    end
  end
end

before do

end

configure do
  set :public_folder, File.dirname(__FILE__) + '/assets'

  set :root_path, File.expand_path(File.dirname(__FILE__))

  set :server_log_file, File.new(File.join(settings.root_path, 'log', 'houz.log'), 'a+')
  settings.server_log_file.sync = true
  use Rack::CommonLogger, settings.server_log_file
  enable :logging

  @@elk_control = Elk::Control.new('192.168.0.6', 2101)
end



get '/' do
  @@elk_control.start
  haml :index
end

get '/hot_water_on' do
  task_activation(2)
  haml :index
end



# def to_hex_string(val)
#   ("0" + val.to_s(16)).slice(-2,2).upcase
# end

# def m1_checksum(message)
#   chk = 0
#   message.each_byte{ |b| chk = (chk + b ) }
#   # two's compliment
#   chk = (-chk & 0xff)#.to_s(16)
#   to_hex_string(chk)
# end

# def assemble_message(message)
#   m = to_hex_string(message.length + 2) + message
#   m + m1_checksum(m)
# end

# def string_number_justify(str, chrs=2)
#   str.to_i.to_s.rjust(chrs, '0')
# end

# def send_message_to_elk(message)
#   s = TCPSocket.open '192.168.0.6', 2101
#   s.puts message
#   s.close
# end

# def task_activation(task_number)
#   message = assemble_message "tn#{string_number_justify(task_number, 3)}"
#   send_message_to_elk(message)
# end


