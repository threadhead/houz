ENV['RACK_ENV'] = 'test'
require 'rubygems'
# require 'sinatra'
require 'rspec'
require 'rspec/mocks'
require 'rack/test'

require File.join(File.dirname(__FILE__), '..', 'houz')
# require File.join(File.dirname(__FILE__), '..', 'lib', 'scanner')
# require File.join(File.dirname(__FILE__), '..', 'lib', 'updater')


# require 'capybara'
# require 'capybara/dsl'


# set test environments
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  # conf.include Capybara::DSL
end

def app
  Sinatra::Application
end
