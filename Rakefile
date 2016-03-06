task :environment do
  require 'bundler/setup'
  require_relative 'config/setup'
end

task :console => :environment do
  require_relative 'models/user'
  ARGV.clear
  require 'pry'
  Pry.config.editor = 'vim'
  Pry.start
end

namespace :db do
  desc "Run database migrations"
  task :migrate => :environment do
    require 'sequel/extensions/migration'
    Sequel.extension :migration
    puts "Migrating to latest"
    Sequel::Migrator.run(Database, "db/migrate")
  end

  desc "Rollback the database"
  task :rollback => :environment do
    require 'sequel/extensions/migration'
    Sequel.extension :migration
    version = (row = Database[:schema_info].first) ? row[:version] : nil
    puts "Rolling back to version: #{version}"
    Sequel::Migrator.apply(Database, "db/migrate", version - 1)
  end
end
