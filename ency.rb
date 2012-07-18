#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/reloader'
#require 'sinatra/compass'
require 'sprockets-sass'
require 'haml'
require 'httparty'
require 'uri'

MAX_AGE = 60
before do
  cache_control :public, :max_age => MAX_AGE
end
set :static_cache_control, [:public, :max_age => MAX_AGE]

get '/' do
  redirect '/opedia'
end

get '/opedia' do
  fetch_wp_page("Main_Page")
end

get '/opedia/terms' do
  haml :terms
end

get '/opedia/privacy' do
  haml :privacy
end


get '/*' do |article|
  fetch_wp_page(article)
end

class Wikipedia
  include HTTParty
  headers({"User-Agent" => "re:Wikipedia 0.1a"})
  follow_redirects false
  base_uri "http://en.wikipedia.org/wiki/"
  def self.get_article(name)
    self.get "/#{URI.escape(name)}"
  end
end

def fetch_wp_page(article)
  res = Wikipedia.get_article article
  if location = res.headers["location"]
    redirect "/#{location.split("/").last}"
  else
    body = res.body
    if match = body.match(/src=\"(\/\/upload.wikimedia[^"]*\d\d\dpx[^"]*)/)
      image = "http:#{match[1]}"
    else
      image = ""
    end

    title = body.match(/title>([^<]*)/)[1]
    title.gsub!("Wikipedia, the free encyclopedia", "").gsub!(" - ", "")

    wp = Haml::Engine.new(File.read("views/wikipedia_hijack.haml")).render Object.new, {
      title:       title,
      description: "The Wikipedia article about #{title}.",
      url:         request.url,
      image:       image,
      root_url:    root_url
    }

    header = Haml::Engine.new(File.read("views/header.haml")).render
    ga = "<script type=text/javascript>  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-33462790-1']);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script>"
    body.gsub!(/<title>([^<]*)/, "<title>#{title}#{" - " unless title == "" }Ency.cl/opedia")
    body.gsub!("</head>", "#{wp}<meta name='viewport' content='width=640, initial-scale=1'></head>").gsub!("/wiki/", "/").gsub!('"/w/index.php', "//en.wikipedia.org/w/index.php")
    body.gsub!('<div id="mw-page-base" class="noprint">', "#{header}#{ga}<div id='mw-page-base' class='noprint'>")
  end
end

def root_url
  "//#{request.host_with_port}"
end
