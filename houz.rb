require 'rubygems'
require 'dotenv'
Dotenv.load

require 'sinatra'
require 'haml'
require 'socket'

if ENV['USERNAME'] && ENV['PASSWORD']
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == ENV['USERNAME'] and password == ENV['PASSWORD']
  end
end

before do

end

configure do
  set :public_folder, File.dirname(__FILE__) + '/assets'

  set :root_path, File.expand_path(File.dirname(__FILE__))

  set :server_log_file, File.new(File.join(settings.root_path, 'houz.log'), 'a+')
  settings.server_log_file.sync = true
  use Rack::CommonLogger, settings.server_log_file
  enable :logging

end

def turn_hot_water_on
  s = TCPSocket.open 'desertsol-apps.net', 2101
  s.puts
end

def to_hex_string(val)
  ("0" + val.to_s(16)).slice(-2,2).upcase
end

def m1_checksum(message)
  # calc the checksum
  chk = 0
  message.each_byte{ |b| chk = (chk + b ) }
  # puts "chk: #{chk}"
  # puts "chk % 256: #{chk % 0x100}"
  # two's compliment
  # chk = 0x100 - chk
  chk = (-chk & 0xff)#.to_s(16)
  # puts "chk 2s comp: #{chk}"

  # chkstr = ("0"+chk.to_s(16)).slice(-2,2)

  # return as 2 digit uppercase hex string
  # chkstr.upcase
  to_hex_string(chk)
end

def assemble_message(message)
  m = to_hex_string(message.length + 2) + message
  m + m1_checksum(m)
end

def string_number_justify(str, chrs=2)
  str.to_i.to_s.rjust(chrs, '0')
end

def task_activation(task_number)
  message = assemble_message "tn#{string_number_justify(task_number, 3)}"
end

get '/' do
  haml :index
end

get '/hot_water_on' do

end
