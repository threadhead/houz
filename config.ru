require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require File.expand_path '../houz.rb', __FILE__

run Sinatra::Application
