require 'cuba'
require 'cuba/safe'
require 'granola'
require 'rack/protection'
require 'yajl'
require_relative '../models/user'
require_relative '../models/user_serializer'
require_relative 'auth'
require_relative 'helper'

Granola.json = Yajl::Encoder.method(:encode)

class App < Cuba
  include Helper

  plugin Cuba::Safe
  plugin Granola::Rack

  define do
    on 'auth' do
      run Auth
    end

    on 'users' do
      users = User.all
      halt granola(users)
    end

    on 'data' do
      puts session.inspect
      if session[:access_token]
        http = Curl.get("https://api.github.com/user") do |request|
          request.headers['Authorization'] = "token #{session[:access_token]}"
          request.headers['User-Agent'] = "Super App"
        end
        json http.body_str
      else
        res.redirect auth_path
      end
    end

    on root do
      session[:counter] ||= 0
      session[:counter] += 1
      res.write "App Up & Running: #{session.inspect}"
    end
  end
end
