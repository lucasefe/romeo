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
      on authenticated do |access_token|
        on 'organizations' do
          as_json fetch_organizations(access_token)
        end

        on root do
          as_json fetch_me(access_token)
        end
      end

      on default do
        res.redirect auth_path
      end
    end

    on root do
      res.write "App Up & Running: #{session.inspect}"
    end
  end

  private

  def authenticated
    lambda { captures << session[:access_token] if session.key?(:access_token) }
  end

  def fetch_me(access_token)
    fetch('/user', access_token)
  end

  def fetch_organizations(access_token)
    fetch('/user/orgs', access_token)
  end

  def fetch(path, access_token)
    http = Curl.get("https://api.github.com#{path}") do |request|
      request.headers['User-Agent'] = "This app I'm building"
      request.headers['Authorization'] = "token #{access_token}"
    end
    http.body_str
  end
end
