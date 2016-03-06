require 'logger'
require 'pg'
require 'sequel'
require 'sequel/plugins/timestamps'

Sequel::Model.plugin :timestamps, update_on_create: true

module DB
  extend self

  def connect(env = nil)
    @connection = create_connection(env)
  end

  def connection
    @connection || connect
  end

  private

  def create_connection(env)
    env ||= ENV['RACK_ENV'] || 'development'
    STDOUT.puts "Connecting to DB: #{env}"
    Sequel.connect("postgres://root:123456@database/#{env}").tap do |db|
      db.logger = Logger.new(STDOUT)
    end
  end
end
