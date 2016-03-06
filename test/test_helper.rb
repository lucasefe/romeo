ENV['RACK_ENV']='test'
require 'sequel'
require 'pg'
require_relative '../config/setup'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

require 'minitest/autorun'
class Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
