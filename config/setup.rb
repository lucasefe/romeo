require 'sequel'
require 'pg'

Database ||= Sequel.connect('postgres://root:123456@database/development')
