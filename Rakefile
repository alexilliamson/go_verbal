require 'bundler/setup'
Bundler.require(:default)

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    Dotenv.load
    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end
end
