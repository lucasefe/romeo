require 'rack/protection'
require 'sinatra/base'
require 'redis'
require 'mysql2'

class SampleApp < Sinatra::Base
  use Rack::Session::Cookie, key: 'rack.session', secret: 'hjjjjjj222'
  use Rack::Protection

  get '/info' do
    'infooo'
  end

  get '/mysql' do
    $mysql ||= Mysql2::Client.new(host: 'mysql', username: 'root', password: '123456')
    $mysql.query('show databases').map(&:inspect)
  end

  get '/redis' do
    $redis = Redis.new(host: 'redis')
    $redis.info.inspect
  end
end

run SampleApp
