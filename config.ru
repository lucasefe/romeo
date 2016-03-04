require 'rack/protection'
require 'sinatra/base'
require 'redis'
require 'mysql2'
require 'pg'

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

  get '/pg' do
    $pg ||= PG.connect(host: 'postgres', user: 'root', password: '123456', dbname: 'rapp_development' )
    $pg.exec( "SELECT * FROM pg_stat_activity" ) do |result|
      result.map do |row|
        row.values_at('procpid', 'usename', 'current_query')
      end.inspect
    end
  end

  get '/redis' do
    $redis = Redis.new(host: 'redis')
    $redis.info.inspect
  end
end

run SampleApp
