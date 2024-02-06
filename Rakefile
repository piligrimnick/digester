# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

namespace :reports do
  desc "fire weekly reports"
  task weekly: :environment do
    Messages::Weekly.new.send
  end

  desc "fire weekly reports"
  task daily: :environment do
    Messages::Daily.new.send
  end
end
