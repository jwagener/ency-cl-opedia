#!/usr/bin/env ruby
require 'sinatra'
require 'haml'

MAX_AGE = 60
before do
  cache_control :public, :max_age => MAX_AGE
end
set :static_cache_control, [:public, :max_age => MAX_AGE]

get '/' do
end

get '/*' do
end
