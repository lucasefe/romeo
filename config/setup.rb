ENV['RACK_ENV'] ||= 'development'

require_relative '../lib/db'
DB.connect
