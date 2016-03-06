task :environment do
  require 'bundler/setup'
  require_relative 'config/setup'
end

task :console => :environment do
  require_relative 'models/user'
  ARGV.clear
  require 'pry'
  Pry.config.editor = 'vim'
  Pry.config.history.file = ".pry_history"
  Pry.start
end

namespace :db do
  desc 'Run database migrations'
  task :migrate => :environment do
    require 'sequel/extensions/migration'
    Sequel.extension :migration
    puts "Migrating to latest (env: #{ENV['RACK_ENV']})"
    Sequel::Migrator.run(DB.connection, 'db/migrate')
  end

  desc 'Rollback the database'
  task :rollback => :environment do
    require 'sequel/extensions/migration'
    Sequel.extension :migration
    version = (row = DB.connection[:schema_info].first) ? row[:version] : nil
    puts "Rolling back to version: #{version}"
    Sequel::Migrator.run(DB.connection, 'db/migrate', target: version - 1)
  end

  task :seed => :environment do
    require_relative 'models/user'
    DB.connection[:users].delete
    User.create first_name: 'Lucas', last_name: 'Florio', email: 'the@email.com'
    User.create first_name: 'Tam', last_name: 'Goldsztajn', email: 'szthe@email.com'
  end
end
