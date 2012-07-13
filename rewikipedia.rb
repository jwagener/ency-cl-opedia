#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
#require 'sinatra/compass'
require 'sprockets-sass'
require 'haml'
require 'httparty'

MAX_AGE = 60
before do
  cache_control :public, :max_age => MAX_AGE
end
set :static_cache_control, [:public, :max_age => MAX_AGE]

get '/' do
  fetch_wp_page("")
end

get '/*' do |article|
  fetch_wp_page(article)
end

def fetch_wp_page(article)
  res = HTTParty.get "http://en.wikipedia.org/wiki/#{article}", :headers => {"User-Agent" => "re:Wikipedia 0.1a"}
  body = res.body
  wp = Haml::Engine.new(File.read("views/wikipedia_hijack.haml")).render Object.new, {
    title:       body.match(/wgTitle\"\:\"([^\"]*)/)[1],
    description: "bla",
    url:         request.url,
    image:       "http:#{body.match(/src=\"(\/\/upload.wikimedia[^"]*)/)[1]}",
    root_url:    root_url
  }
  body.gsub("</head>", "#{wp}</head>").gsub("/wiki/", "/")
end

def root_url
  "//#{request.host_with_port}"
end
