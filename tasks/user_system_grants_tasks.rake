namespace :user_system_grants do
  desc 'Migrate'
  task :migrate => :environment do
    ActiveRecord::Base.establish_connection
    require File.join(File.dirname(__FILE__), '..', 'db', 'user_system_grants_migrator')
    UserSystemGrantsMigrator.migrate(
      File.join(File.dirname(__FILE__), '..', 'db', 'migrate'),
      ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    )
  end
end
