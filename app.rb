require 'rack/protection'
require 'cuba'
require 'cuba/safe'

class App < Cuba
  use Rack::Session::Cookie, key: 'rack.session', secret: 'hjjjjjj222'
  use Rack::Protection

  plugin Cuba::Safe

  define do
    on root do
      res.write 'App Up & Running'
    end
  end
end

