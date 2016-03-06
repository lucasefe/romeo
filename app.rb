require 'cuba'
require 'cuba/safe'
require 'granola'
require 'rack/protection'
require 'yajl'
require_relative 'models/user'
require_relative 'models/user_serializer'

Granola.json = Yajl::Encoder.method(:encode)

class App < Cuba
  use Rack::Session::Cookie, key: 'rack.session', secret: 'hjjjjjj222'
  use Rack::Protection

  plugin Cuba::Safe
  plugin Granola::Rack

  define do
    on 'users' do
      users = User.all
      halt granola(users)
    end

    on root do
      res.write 'App Up & Running'
    end
  end
end

