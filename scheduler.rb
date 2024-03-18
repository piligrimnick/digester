#!/usr/bin/env ruby

require 'rufus/scheduler'
require_relative "config/boot"
require_relative "config/environment"

ENV['TZ'] = "Europe/Madrid"

scheduler = Rufus::Scheduler.new


scheduler.cron("30 8 * * *") do
  Messages::Daily.new.send
end

scheduler.cron("30 9 * * 7") do
  Messages::Weekly.new.send
end

scheduler.join
