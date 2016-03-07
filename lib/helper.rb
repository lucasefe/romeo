require 'redis'
require 'rack/session/redis'
require 'rack/protection'
require 'json'

module Helper
  def self.included(app)
    app.use Rack::Session::Redis, redis_server: 'redis://redis:6379/0/rack:session'
    app.use Rack::Protection
  end

  def as_json(output)
    res.headers['Content-Type'] = 'application/json; charset=utf-8'
    res.write output.kind_of?(String) ? output : JSON.dump(output)
  end

  def data_path
    "/data"
  end

  def auth_path
    "/auth"
  end
end
