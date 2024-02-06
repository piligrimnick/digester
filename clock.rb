require "clockwork"
require_relative "config/boot"
require_relative "config/environment"

module Clockwork
  configure do |config|
    config[:sleep_timeout] = 60
    config[:tz] = "Europe/Madrid"
  end

  every(1.day, "Messages::Daily", at: "8:30") do
    Messages::Daily.new.send
  end

  every(1.week, "Messages::Weekly", at: "Sunday 10:30") do
    Messages::Weekly.new.send
  end
end
